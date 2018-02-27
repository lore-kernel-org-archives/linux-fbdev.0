From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 00:04:17 +0000
Subject: [PATCH 0/3] console: Expand dummy functions for CFI
Message-Id: <1519689860-7421-1-git-send-email-keescook@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is a small series that cleans up struct consw a bit and
prepares it for Control Flow Integrity checking (i.e. Clang's
-fsanitize=CFi).

Thanks!

-Kees
