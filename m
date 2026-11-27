Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745704;
	b=dz7D4gav9ReXdpJtLP7zyWXj7eoTB08PBDyWa946y+D+m9xtJkqmJKY3SyoJQE9ZBoOJ
	 En5nZLRw78r6/pFhYB7Tr3YjGgpLlrkP8/FRC5bNdhsbHpgQ0xH8rZ/C6Mbh6kbbAuuW2
	 9O8fnJYXa0xKLyXrAuUMiltWlYZourWoCjv7dc7CeHxKJppu44iMRz1AOYfrPraNJP+NL
	 mOUB4g10oVIGL1u1lTNQDzDrjF21ji/0qQTXSc+iZPp22FtE86hGhbnmPvVdHZ9KQN1Wd
	 XILO5PuzgkmxelO47IrvoaaJB04ZSW1VNextkMBf3Wg+2GGN2vLXzItdk4PflajWpXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=AxO6ITynFYCz3tbaMENDiJEbA1Xn/FD4c7DpBtb53bw=;
	b=G7tDhTBFB7zPqIBVXvO/+n5x5ISBzQ04l2PD6AEqydW7tnS/SXIMLRtdcO3hNRk5dfzV
	 S1+gZ0W80KtHbdU7pn3FCQti1QfVrOVJwEDLWMb04qICw/kjE23O+JUsfKU43mmIxZPsc
	 1Rb1mISDNw4Nf3iaD2ZqEYiL+gpZJ1G2uBjq/a2ZKqeebZwsi1jd8/iNYmFP3+8XPlRPg
	 MTn1B8euMnlZMbZKyxY4+c2rADf5dYjEyp/Ytr30D/FCZ0WJ22FeAcTvKW/KdQmaxppAI
	 UauFjV+II7f/QZMmfy0SdmfXwrsQBJh0FUSzrdzIb+mLELOlundV3ikgtYi7eQoqZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+5hGzMb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A3606A31E
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+5hGzMb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC821F000C1;
	Fri, 27 Nov 2026 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795745704;
	bh=AxO6ITynFYCz3tbaMENDiJEbA1Xn/FD4c7DpBtb53bw=;
	h=From:To:Cc:Subject:Date;
	b=M+5hGzMb0Dv0e7MP9/ygGNIsrN/GQKIsP4HBIflDhn/YloB3b0rPuljc15qttw4iS
	 2szIK9KEpwvqFEezDjtqMEYahpYkIzKlXhLJsUCVXHwgagq/e5Ivu/GvfdlokvCVyV
	 8FLUG7Z+NlgF+hIcK1ICqltDMMcLYh87rsvXwf4lkxGUQ1yVfWnBLW9xfY9aLw8jye
	 3nXzIjfl1hClv5jRq8GAOGOTys3CDV/TD372Wuet/oA90m4c0lKUU9OqwtDk7AUd28
	 Sy6Ux+4ead4CBUdPR9V4wLdRepW8DBPiFDQAEMQC9mWX4iH2khAgeODwzuQ1DBRHQe
	 XAzGqOSAnmJlQ==
From: Thorsten Blum <blum@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Pengyu Luo <mitltlatltl@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Junjie Cao <caojunjie650@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: aw99706: Clamp negative max brightness values
Date: Fri, 27 Nov 2026 03:14:23 +0100
Message-ID: <20261127021423.656745-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=blum@kernel.org; h=from:subject; bh=0R0jCEkBvOQqFhQNu9vWsv/8OunR3DCCny4Kf8o4nvE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNkcz+s762/MerP9wkxp3vs9p8vWX05a+OaZ5+XT5TKfl /ff+n/oY0cpC4MYF4OsmCLLg1k/ZviW1lRuMonYCTOHlQlkCAMXpwBMpLOY4a/oXu77y999+Lbv +Odnh6o/2hdvPrL+0ouq6ZK/3N82ZzouYfgrwxQn9Pb2L/GmK0brXkxwUDurcsjKgf9iqGiMxRP zDYFMAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

device_property_read_u32() reads the "max-brightness" property directly
into the signed int max_brightness field. Values larger than INT_MAX are
interpreted as negative and pass the upper-bound check.

Also clamp negative values to AW99706_MAX_BRT_LVL to prevent this.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/aw99706.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 43f82c83f91a..c8168a36284d 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -272,7 +272,8 @@ static void aw99706_dt_parse(struct aw99706_device *aw,
 	device_property_read_u32(aw->dev, "max-brightness",
 				 &bl_props->max_brightness);
 
-	if (bl_props->max_brightness > AW99706_MAX_BRT_LVL)
+	if (bl_props->max_brightness < 0 ||
+	    bl_props->max_brightness > AW99706_MAX_BRT_LVL)
 		bl_props->max_brightness = AW99706_MAX_BRT_LVL;
 
 	if (bl_props->brightness > bl_props->max_brightness)
