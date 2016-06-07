From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Tue, 07 Jun 2016 15:27:55 +0000
Subject: linux-4.7-rc2/drivers/video/fbdev/intelfb/intelfbdrv.c:1041]: (style) Redundant condition
Message-Id: <CAMzoamZ0zDO+7NL4o84CPQ9u+wqCiuwxL0Sk73XQUoFyBjJaeA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mbroemme@plusserver.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dcb314@hotmail.com

Hello there,

linux-4.7-rc2/drivers/video/fbdev/intelfb/intelfbdrv.c:1041]: (style)
Redundant condition: If 'msrc > 1', the comparison 'msrc' is always
true.

Source code is

            if (msrc && msrc > 1) {

Maybe better code

            if (msrc > 1) {


Regards

David Binderman
