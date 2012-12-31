From: "devendra.aaru" <devendra.aaru@gmail.com>
Date: Mon, 31 Dec 2012 21:04:32 +0000
Subject: backlight_register_device can oops if name is null ?
Message-Id: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

while reading through the backlight_register_device function, there
seems to be a problem if the new object name is null, the pr_debug
print goes and dereferences a null pointer causing an oops,

the print should be removed or the check must be placed to ensure that
name is not null,

any ideas?
