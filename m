From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Sep 2010 07:33:48 +0000
Subject: [PATCH 07/12] viafb: reduce I2C timeout and delay
Message-Id: <bc04fc99ee764b565490e48226899ce0567189e3.1284879532.git.FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
In-Reply-To: <171e0fb74a34b069c0c12aa90c56d5e5da5489c6.1284879532.git.FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>, Jonathan Corbet <corbet@lwn.net>

viafb: reduce I2C timeout and delay

This patch reduces the value for I2C timeout and udelay.
The udelay was reduced to 10 (old: 40) which is still very high as for
standard-mode I2C even 5 should work. This gives a speedup of factor 4
when talking to I2C devices.
The timeout was reduced to 2 (old: 20) which is taken from the radeon
driver so it should work as well. This gives a speedup of factor 10 when
detecting that there is no I2C device we want to talk to.
This causes a huge improvement of device initialization time.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via_i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index 021112e..3844b55 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -202,8 +202,8 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
 	algo->setscl = via_i2c_setscl;
 	algo->getsda = via_i2c_getsda;
 	algo->getscl = via_i2c_getscl;
-	algo->udelay = 40;
-	algo->timeout = 20;
+	algo->udelay = 10;
+	algo->timeout = 2;
 	algo->data = adap_cfg;
 
 	sprintf(adapter->name, "viafb i2c io_port idx 0x%02x",
-- 
1.6.3.2

