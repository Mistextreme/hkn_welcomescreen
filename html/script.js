let autoTimer;

function setThemeColor(hex) {
    if (!hex) return;
    hex = hex.toString().replace('#', '').trim();
    let r = 255, g = 255, b = 255;

    if (hex.length === 8) {
        r = parseInt(hex.slice(2, 4), 16);
        g = parseInt(hex.slice(4, 6), 16);
        b = parseInt(hex.slice(6, 8), 16);
        hex = hex.slice(2, 8);
    } else if (hex.length === 6) {
        r = parseInt(hex.slice(0, 2), 16);
        g = parseInt(hex.slice(2, 4), 16);
        b = parseInt(hex.slice(4, 6), 16);
    } else if (hex.length === 3) {
        r = parseInt(hex.charAt(0) + hex.charAt(0), 16);
        g = parseInt(hex.charAt(1) + hex.charAt(1), 16);
        b = parseInt(hex.charAt(2) + hex.charAt(2), 16);
        hex = hex.charAt(0) + hex.charAt(0) + hex.charAt(1) + hex.charAt(1) + hex.charAt(2) + hex.charAt(2);
    }

    if (isNaN(r) || isNaN(g) || isNaN(b)) {
        r = 255; g = 0; b = 102; hex = "FF0066";
    }

    const root = document.documentElement;
    root.style.setProperty('--pink', '#' + hex);
    root.style.setProperty('--pink-glow-5', `rgba(${r}, ${g}, ${b}, 0.5)`);
}

function resetTimer(isLast, duration) {
    clearTimeout(autoTimer);
    const ms = (duration || 5) * 1000; // saniyeyi milisaniyeye çevir
    
    autoTimer = setTimeout(function() {
        if (!isLast) {
            $.post(`https://${GetParentResourceName()}/next`, JSON.stringify({}));
        } else {
            $.post(`https://${GetParentResourceName()}/skip`, JSON.stringify({}));
        }
    }, ms);
}

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        let item = event.data;

        if (item.action === "setTheme") {
            setThemeColor(item.themeColor);
            return;
        }

        if (item.action === "setupLocales") {
            $('#btn-next').text(item.locales.next);
            $('#btn-back').text(item.locales.back);
            $('#btn-skip').text(item.locales.skip);
            $('#btn-finish').text(item.locales.finish);
        }

        if (item.action === "hide") {
            clearTimeout(autoTimer);
            $('#ui-container').fadeOut(400, function() { $(this).addClass('hidden'); });
            return;
        }

        if (item.action === "show") {
            $('#ui-container').removeClass('hidden').hide().fadeIn(400); 
            
            if (item.title) $('#loc-title').text(item.title);
            if (item.description) $('#loc-desc').text(item.description);
            if (item.current) $('#page-count').text(item.current + " / " + item.total);

            if (item.isFirst) { $('#btn-back').hide(); } else { $('#btn-back').show(); }
            if (item.isLast) {
                $('#btn-next').hide();
                $('#btn-finish').show();
            } else {
                $('#btn-next').show();
                $('#btn-finish').hide();
            }

            resetTimer(item.isLast, item.duration); // duration'ı geçir
        }
    });

    $('#btn-next').click(function() { $.post(`https://${GetParentResourceName()}/next`, JSON.stringify({})); });
    $('#btn-back').click(function() { $.post(`https://${GetParentResourceName()}/back`, JSON.stringify({})); });
    $('#btn-skip').click(function() { $.post(`https://${GetParentResourceName()}/skip`, JSON.stringify({})); });
    $('#btn-finish').click(function() { $.post(`https://${GetParentResourceName()}/skip`, JSON.stringify({})); });
});