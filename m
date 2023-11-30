Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 3AB17D7F;
	Wed, 29 Nov 2023 21:12:25 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 74E2861FB526E;
	Thu, 30 Nov 2023 13:12:15 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	nathan@kernel.org,
	ndesaulniers@google.com,
	trix@redhat.com
Cc: Su Hui <suhui@nfschina.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] backlight: ili922x: add an error code check in ili922x_write
Date: Thu, 30 Nov 2023 13:11:56 +0800
Message-Id: <20231130051155.1235972-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static analyzer complains that value stored to 'ret' is never read.
Return the error code when spi_sync() failed.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/video/backlight/ili922x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index e7b6bd827986..47b872ac64a7 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -269,6 +269,10 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
 	spi_message_add_tail(&xfer_regindex, &msg);
 
 	ret = spi_sync(spi, &msg);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Error sending SPI message 0x%x", ret);
+		return ret;
+	}
 
 	spi_message_init(&msg);
 	tbuf[0] = set_tx_byte(START_BYTE(ili922x_id, START_RS_REG,
-- 
2.30.2

