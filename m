From: Daniel Drake <dsd@laptop.org>
Date: Wed, 13 Apr 2011 20:59:30 +0000
Subject: viafb: XO-1.5 video broken on 2.6.39
Message-Id: <BANLkTimFS0yC2629V0tBQQZG+9hJTkSctw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Commit fd3cc69848b7e1873e5f12bbcdd572b20277ecf3 breaks video on the
XO-1.5 laptop on 2.6.39:

commit fd3cc69848b7e1873e5f12bbcdd572b20277ecf3
Author: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date:   Fri Mar 11 00:04:01 2011 +0000

    viafb: remove duplicated clock storage

This is using the 1200x900 mode (DCON1200x900)

In the old code, the clock was hardcoded as value 57275000.
In the new code, the clock gets calculated as 1264x912x60 = 69166080

The result is that the screen gets filled with black and grey
horizontal lines instead of anything readable.

Any ideas?

Thanks,
Daniel
