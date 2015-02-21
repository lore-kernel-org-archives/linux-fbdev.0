From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 21 Feb 2015 15:18:16 +0000
Subject: imxfb does not turn on automatically
Message-Id: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Carlos Soto uses a Karo mx25 and he noticed that the LCD only works if we do:

echo 1 > /sys/class/graphics/fb0/blank
echo 0 > /sys/class/graphics/fb0/blank

I can confirm the same on mx25pdk running 3.19 [1], but I could not
understand why the display does not start turned on by default.

[1] http://www.spinics.net/lists/arm-kernel/msg399949.html

Any ideas?

Thanks,

Fabio Estevam
