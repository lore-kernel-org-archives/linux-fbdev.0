Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793542448;
	b=BTaaDl0YkYmmKPdkH92qxrV8MRk+hb5KC7xrO8Vct1t7VfswUCAWyVWL7GSocXL7z2pJ
	 HrzbN+koH81xsT/HoJ+lVEi2GeyYdsBNX9x1+FgOI6CXi5K15FEvslZes7r0Sw/ghIK8l
	 /9dTcc0JVhP8OY+xxMcj9p6+xBaO/CqLCXiqZpMgHa0TPb8P27SvmJz1Q8Y2CYaicPrxj
	 9GvmXHmymDnNt/xjTkt2Q6Kx0peOjPN2iRyvvUtI3MouSa4IjBEwTahHUR0r166JEAxM9
	 lBGgNZsmdLNdf7UdLwQFQU1RJERdKDZYcXdSwMTNhZInh55Bo6TAigqEtZRRj/SQRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542448;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version:
	 X-Virus-Scanned:X-Virus-Status:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=Cl9hy9YYhL32GGldSV0IAqtmMtjOc9MnfGr8wLQ4nco=;
	b=4D5UeGcYCOl+6DhIhvkK6ZEDUaPn6RmGIn/cgw7RnyVeMaKWmlEl1iDNd5l/fwF8TtoR
	 nqnFr5YmMngeKbYrCwPKPsFdTWNWBolr9lj7VQyX9odwTWi/GVksT5rr1tuVU6JsnWloR
	 KL/Cb+FTQ6gbxzgBZ9sXQATUqv7D8yxSJN0DEZL6kWBW0CJNEWIGVgXLTmaNtJs1fOudL
	 FrIeQzsgA3dI1iA94bpQ353qahH+j8oCcED4hoe6NlgEItjvYKMSKOriVcj8E7YPIpoqs
	 /di48205U/QOrrSxOPbjNv/L82gKcuqE9/yQJStR8AZp6YTcWdetbr0ckTLNHyNI/+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=morknet.de;
	spf=pass smtp.mailfrom=morknet.de;
	dkim=pass header.d=morknet.de header.i=linux-dev@morknet.de header.a=rsa-sha256 header.s=s1-ionos header.b=0rnXZrHd;
	arc=none smtp.remote-ip=212.227.126.187
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD1606A330
	for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2026 14:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACD1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morknet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morknet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=morknet.de header.i=linux-dev@morknet.de header.a=rsa-sha256 header.s=s1-ionos header.b=0rnXZrHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=morknet.de;
	s=s1-ionos; t=1793542438; x=1794147238; i=linux-dev@morknet.de;
	bh=Cl9hy9YYhL32GGldSV0IAqtmMtjOc9MnfGr8wLQ4nco=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=0rnXZrHda/dhn7kvBO5kU8lJgBh/8J4xkH7txXDmsKJdjN2+b9sIYR2IWljpPDwc
	 47uTZWrAngI9Zo1seTlyii9t8/oLHuMr13qgliKa0GaygGAuk2ABsHugmJ7iQyk8J
	 VPHcOojNZRLeV+aWWo1lLrD6e/KsrJHRafpandFqYWazOdtlHgxPBzNuWYwawHmCl
	 TBK+WrEzucfTi1QETj2dmkfRoAR8amELaX7V4x5f7WQ8JNd20solPNDebAH2/I6yg
	 h0ang9bORgONR9+3KlW9xMDEQo9PQAqyf2rly3Bh8xOeqh8u3/46N6AyTDaCwkCBu
	 NJ2QL8XmH/TQRb6nxQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M433w-1xNWJq2GJs-00AS5k for
 <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2026 15:13:58 +0100
Received: from sagittarius.morknet.de (sagittarius.morknet.de [192.168.19.11])
	by mail.morknet.de (8.18.1/8.18.1) with ESMTPS id 6A1EDv6i3108290
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 1 Nov 2026 15:13:57 +0100
Received: from sagittarius.morknet.de (localhost [127.0.0.1])
	by sagittarius.morknet.de (8.18.1/8.18.1) with ESMTP id 6A1EDvTA997858;
	Sun, 1 Nov 2026 15:13:57 +0100
From: "Steffen A. Mork" <linux-dev@morknet.de>
To: linux-fbdev@vger.kernel.org
Cc: "Steffen A. Mork" <linux-dev@morknet.de>
Subject: [PATCH] video: fm2fb: Fixed iomem access.
Date: Sun,  1 Nov 2026 15:13:27 +0100
Message-ID: <20261101141327.997784-1-linux-dev@morknet.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.5.4 at scorpius
X-Virus-Status: Clean
X-Provags-ID: V03:K1:kl0WdVES1XkekF8TjQ61A7hWLcv900FeMh6vJ6P7U+hNSDetiEE
 Rl36UpkZu8eZhub7d0tkNAGKmltwGDftGCE0Bz1CfrNXCxCcpCZG/ttMhLgR3tC/E4V+WUa
 9m6hjeKsL4jQI9NfBCB4uhUkdBp4384wkoUvLfQuf9g9ulrhL+GLjpxTzAxjZ9Z1yIUcwRm
 tcda7MSH3UnmlDHBCVQMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsgqZFuyW/A=;UER+QQuiyHHRz2Pq7lpbY7WzmV9
 AKbh+PrnZh4Q5X3E1tSy2QGYqkL78dx2Ydm2mRsr4U00FYLYng/5SZtUjI3ksf43S+zUl9r7b
 b0ZQlyPb0M7QGjWU1rQoQ/cbe8CJRnBURN8SL/tHwIhtVtRMj0pPMDub3x632LmBjED8RIyl7
 WhbBYSYbvNkhWsiTvMAt/+3VI/vkOofZnuuRh0WK3xakMgsF3eh3UDbz+RG9PEHF3Q/CZVi4M
 qwop1elz/FZdcoDv2ZBoE4mQsIPVm9MqAuv+JdWLETkogJAGTzN4OEgT3Ew8qpytWarCQ5ODa
 xMjBspwTZuF8bxdAaTVTs7gVk0z10Q6Mxzyb0XUcJBokzalkdVpb539oPEGeuAuMTLXnLL8v0
 sUXn2rIXHWeBleF+imH5eeeXv2pd4l6kAXsLMGF6jeuATngCuJeUHFQc1uzyAGjn+2m5CUQbk
 /A+4eOwu+oXOeHkxC0iyU+MjcvfPYMImHBfFGvzmT9igv4riwd0et/+3QGCky3tKMnUs0ydTH
 2r8YnpYMIpFWD3EWtg5WUgGKxA5xVr2UTKNRpmZTele3CpNLavhw2lEyCvyaGHf30JmCCB2ff
 GNZM62IKlQBGCrkDxABkTsBCicshE5ZujSP0aybQNqQxu/syGIP07eJtAIiQLqsX4sXnO3ahp
 /iktVKdTwKGqR/00sMTXG55irkzCtkXOe8ss3h65lNUjduY4X2aTP9NJWxDkIvlOCdlxCOgtk
 aj3sXnpD/LWAhljN+44V8fH+OxD7qgdHrOB5eOONv8bwql6WNMxyya9Xl4YkY52yuK5/LTOpT
 64Gwlx3MeBYPESu1xtVrQxy/O/q4inAiBVg8QH4OKVUnXnxfPPtxnSFD1xZM8EUmW1sc/xVWm
 KZPcLV2IXmpY9kVa3k3iQRCGUEn4J8OrNDbmJWpV5B8gL5ePEpJl/ACvJ9Vo3ArzcVTscAef5
 18CqBmXf6SGbJ0DI+eiDD2749lxMiX1CcggZWzvYWOpQ0whrkEz7oqmC9X8EbbCkMNDjRV/5o
 tBq2Psu6MwJuIxhRTnNRcl5/SC91KYNNDHzkpESV3WocQtNBUJp586vplCqZNG/oKSRtLVugh
 vQc6580eKa1abVSo4wUITOYMLrmB6QTOzhlCanrxyKafLRYSEw9b3Iw6rrrV6MwuIan2bEwQL
 3xBz/jNGHp7MHtnjsC+AC6gjRDTAlfZc8hdBJvfpbn4xTQBcRt5n6pyvhFarQHKEtg8HrONJK
 V/4A+1F8cN7/wSTjZwwtl0rUQITLpShCPHsHopnn+pTEHuVpSfQXUpjR3g7V/uYykMDrmrBiF
 TRV/Ox3TsGpiUULuWvxSLZLgfVinSlZhQ6nWe6uQWPpFR1UIL62vfmaOfoNS5XtzMO+tociVu
 ptYAsvGd+RPCsX0WisOpNlqgL4T71gthIZolc/Rt1bHIhjfq0v2wPOIBQnEyVOwZ4HuwPfRBT
 1LnoLzjBpPjqj+UBTVqm82SUgF5VwNqcmOFAejw9XcKjzwHVZ5o3UVcEqFsLXDzAcD7rvbo6Z
 CbaVTYMQGd5gAnsKwctnKmguJjSCByf755bEaMnyhnxqPpX/Oiz5FrdmE8IWonWaBYl7tJl32
 DrwWyNtp2YF0cJbBYYAEGqk1SgHQ9LOmDnSMbkVr0XNWsD9+H9lqVba0u/7K+3QXmIC1ygbXv
 BdjP0kJqYclFiqgFCR1e3DwvRwUL8sAcWY2851L7DgsTUJGthmYpZJKsbT9YvHMEjfvDa/Oyd
 bj2LdXw/n8QHN/8LxvluMKrTLVLCTZJue/cFctefv/+ACfT6W9n6ACVm+OagmSVdRgHhPxds6
 BpeTUgJqRWPSJmjZFqKWjpZ5t5ALEHa9TFV7ITbBso0mkDgJNdn7JPb6LNUGzElLqx98Az2vf
 k15L7APUZ2DEyKt9NDMSxcm/tI6gFbcghUspqWtwpC2iPBvjSt+Gy4viUqNv2QVrD8Hvyjl/V
 OgFmK152snd+vnKtpzYD+5F/ZKVWRxAL82V5Osm++ibFZlpQImT8PNnKwl9uIqS3Ctsi1MJ/J
 y5h1Tz00LHxpDMw2cQRVvmcS1JZbiUbeaEFe/Yk75CKOejLWMiCsVFhhlXAuMVnWatBThy4Vv
 nDp641Wgml/VcIhgrKduejKz+lYRGn6eIl0ECNQGoMIYa5RwJjLg5Tday79agRTcRopDj++/X
 8rOMH18OJiGl0cccj6M7x7gEIuWiBu9T2N8beB814td4YKLqd9EdxUVeVXF5viapEqiqM5vGV
 t5T4mqG9/PJnMP8r6HqrDrEwioGvwThNMYpyA3J4KT5TAuQJz7mF6IOEDt3ecWopjx8U8NppW
 S9IC1O3J7l+21slW8EzB9zuy1jiWcRda6lGgI3VrqD3g+hY1r/cc6Rj9mpVGZCzC/Xup1QRgV
 NvlscQdUjLidai/NU9Pobli+ozvl2WaXWHUllDESOkmgdwV8id1QOFG184KTK6MRGgHaFCpxv
 kTa+ZKR/LP5dyaewTQHvMdHdheR6Nk1LnnCyelqc69IDdGJ4Z97FTIfOFrPCq8AmHXFE4P6jE
 03zKX4367PaBl9fSgAgFT533NiY/6HLxi6OuxFRgrawDkqJvM1xf15ZOopNstilck12oO7kUn
 RCYswAhiK8dDVvnxNHLxbkrXD+5/ILiqkBwE3BzXVCLRbCQs4Ez+VlyggJZY4wZngwVqNGxAE
 NXcDg80laZFcXdRyjIMjKbQire4ga1XcawdsKLStqMdFk8mL4ml2u0JqpcR/ZxKK04vpn1CXa
 pYSw4CJSby3jB5haR8jkVs7ikDqmrQTDFTkydHSfjAkuXyuhayT4lHLJnXf7zAY12JapUQpkH
 6s+bNJAFFsuUIHNcouUGGaBV/nAn3/MX/LkV1U7GN724BgfMDupumXySOOL+I/3Jn6JS/G1u1
 /DhXuP1euErmHMtAdsKcRsrfWfcfH4wgErs5owJT5fI/nl4yiPVjw/jEmHJ2O0pWfvfnM/K1o
 LdomZ3OTYUB+4ZK025gzbiHPJWn7UHwQEzoGL5gkwJ1tV3sTutS0NvzRcuf5qn5GlSV0wpy2L
 1/+oMFDTzy+yOPJtEo6U93AoDV3jWQ9a+ijeGAmHhzrskw6yW/iE/NsH2BU4XdLnfRNmRk86Y
 NN4bUqjVCCrIw=

This driver has not been tested for at least twenty years. In the meantime=
,
the frame buffer API has been updated. This patch addresses this issue and
makes the driver functional again.

Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>
=2D--
 drivers/video/fbdev/fm2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fm2fb.c b/drivers/video/fbdev/fm2fb.c
index 25d2e716edf2..ed4457df7707 100644
=2D-- a/drivers/video/fbdev/fm2fb.c
+++ b/drivers/video/fbdev/fm2fb.c
@@ -257,7 +257,7 @@ static int fm2fb_probe(struct zorro_dev *z, const stru=
ct zorro_device_id *id)
 	strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
=20
 	/* make EBU color bars on display */
-	ptr =3D (unsigned long *)fb_fix.smem_start;
+	ptr =3D (unsigned long *)info->screen_base;
 	for (y =3D 0; y < 576; y++) {
 		for (x =3D 0; x < 96; x++) *ptr++ =3D 0xffffff;/* white */
 		for (x =3D 0; x < 96; x++) *ptr++ =3D 0xffff00;/* yellow */
=2D-=20
2.43.0

