Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37B1487CE;
	Fri, 14 Jun 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348010; cv=none; b=mkRKQZ9sXmREDjdRy0Wsn4pm5cB2UaVzV4Gzue07NYx7oI+in4ydTEhDR9QOCX0Auyqxe1xLeuWZiqFOSv7p2Bhcm4k4nHZlFi7fwDE3inDvxjF9PD2mGPP5eH3xco/xwTG8NM3GQS+WtHiTIoH5RJD16IPvTpOD108KC4KSayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348010; c=relaxed/simple;
	bh=vIW7li7wJXGnKEAu4EmEFyjNvS+txbkQ4Joc6QIt2Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gbzgc0zwd1QBRIb2SWN1LOMvKyEugn5xTxEoFQQheponkpEL+5wA3VpQNEnI4EogVlmWye9xVtqMBRprm8+oRWU2uJpbJO6pIyH5+2ksbYH1BEpV8lj9VjjHiqQ/8/RUIgtBYOCKW9ihobtbi6W4C0F3rE5HSro4q0cPAAfw5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rr2hsafO; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rr2hsafO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718348003; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9OInBtkue1NKgMTGtXJY55uTTmBbPccoSR6cScp+80U=;
	b=rr2hsafOXll6gibtDrbY8MsRfcEMhsB7MNt063xO3sn/FgoRhLY/7Oo1UAwk5Xb7U970qHGv282nX9iZhiOVbqp5yED5Bciw+J09vvOcwH0Db9sP6nxY+8Mqmx1yPXT06X2sCNW/mAcnTBAGroW+8kPYx2N0S0dzmGJpT+Wocuo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8QEou9_1718347994;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8QEou9_1718347994)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:53:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] video: fbdev: sis: clean up some inconsistent indenting
Date: Fri, 14 Jun 2024 14:53:13 +0800
Message-Id: <20240614065313.117790-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/video/fbdev/sis/sis_main.c:2511 SiS_Sense30x() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9330
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/video/fbdev/sis/sis_main.c | 502 +++++++++++++++--------------
 1 file changed, 260 insertions(+), 242 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 009bf1d92644..fc5b9a0d78bf 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -2384,266 +2384,284 @@ static int SISDoSense(struct sis_video_info *ivideo, u16 type, u16 test)
 
 static void SiS_Sense30x(struct sis_video_info *ivideo)
 {
-    u8  backupP4_0d,backupP2_00,backupP2_4d,backupSR_1e,biosflag=0;
-    u16 svhs=0, svhs_c=0;
-    u16 cvbs=0, cvbs_c=0;
-    u16 vga2=0, vga2_c=0;
-    int myflag, result;
-    char stdstr[] = "sisfb: Detected";
-    char tvstr[]  = "TV connected to";
-
-    if(ivideo->vbflags2 & VB2_301) {
-       svhs = 0x00b9; cvbs = 0x00b3; vga2 = 0x00d1;
-       myflag = SiS_GetReg(SISPART4, 0x01);
-       if(myflag & 0x04) {
-	  svhs = 0x00dd; cvbs = 0x00ee; vga2 = 0x00fd;
-       }
-    } else if(ivideo->vbflags2 & (VB2_301B | VB2_302B)) {
-       svhs = 0x016b; cvbs = 0x0174; vga2 = 0x0190;
-    } else if(ivideo->vbflags2 & (VB2_301LV | VB2_302LV)) {
-       svhs = 0x0200; cvbs = 0x0100;
-    } else if(ivideo->vbflags2 & (VB2_301C | VB2_302ELV | VB2_307T | VB2_307LV)) {
-       svhs = 0x016b; cvbs = 0x0110; vga2 = 0x0190;
-    } else
-       return;
-
-    vga2_c = 0x0e08; svhs_c = 0x0404; cvbs_c = 0x0804;
-    if(ivideo->vbflags & (VB2_301LV|VB2_302LV|VB2_302ELV|VB2_307LV)) {
-       svhs_c = 0x0408; cvbs_c = 0x0808;
-    }
-
-    biosflag = 2;
-    if(ivideo->haveXGIROM) {
-       biosflag = ivideo->bios_abase[0x58] & 0x03;
-    } else if(ivideo->newrom) {
-       if(ivideo->bios_abase[0x5d] & 0x04) biosflag |= 0x01;
-    } else if(ivideo->sisvga_engine == SIS_300_VGA) {
-       if(ivideo->bios_abase) {
-          biosflag = ivideo->bios_abase[0xfe] & 0x03;
-       }
-    }
-
-    if(ivideo->chip == SIS_300) {
-       myflag = SiS_GetReg(SISSR, 0x3b);
-       if(!(myflag & 0x01)) vga2 = vga2_c = 0;
-    }
-
-    if(!(ivideo->vbflags2 & VB2_SISVGA2BRIDGE)) {
-       vga2 = vga2_c = 0;
-    }
-
-    backupSR_1e = SiS_GetReg(SISSR, 0x1e);
-    SiS_SetRegOR(SISSR, 0x1e, 0x20);
-
-    backupP4_0d = SiS_GetReg(SISPART4, 0x0d);
-    if(ivideo->vbflags2 & VB2_30xC) {
-	SiS_SetRegANDOR(SISPART4, 0x0d, ~0x07, 0x01);
-    } else {
-       SiS_SetRegOR(SISPART4, 0x0d, 0x04);
-    }
-    SiS_DDC2Delay(&ivideo->SiS_Pr, 0x2000);
-
-    backupP2_00 = SiS_GetReg(SISPART2, 0x00);
-    SiS_SetReg(SISPART2, 0x00, ((backupP2_00 | 0x1c) & 0xfc));
-
-    backupP2_4d = SiS_GetReg(SISPART2, 0x4d);
-    if(ivideo->vbflags2 & VB2_SISYPBPRBRIDGE) {
-	SiS_SetReg(SISPART2, 0x4d, (backupP2_4d & ~0x10));
-    }
-
-    if(!(ivideo->vbflags2 & VB2_30xCLV)) {
-       SISDoSense(ivideo, 0, 0);
-    }
-
-    SiS_SetRegAND(SISCR, 0x32, ~0x14);
-
-    if(vga2_c || vga2) {
-       if(SISDoSense(ivideo, vga2, vga2_c)) {
-          if(biosflag & 0x01) {
-	     printk(KERN_INFO "%s %s SCART output\n", stdstr, tvstr);
-	     SiS_SetRegOR(SISCR, 0x32, 0x04);
-	  } else {
-	     printk(KERN_INFO "%s secondary VGA connection\n", stdstr);
-	     SiS_SetRegOR(SISCR, 0x32, 0x10);
-	  }
-       }
-    }
-
-    SiS_SetRegAND(SISCR, 0x32, 0x3f);
-
-    if(ivideo->vbflags2 & VB2_30xCLV) {
-       SiS_SetRegOR(SISPART4, 0x0d, 0x04);
-    }
-
-    if((ivideo->sisvga_engine == SIS_315_VGA) && (ivideo->vbflags2 & VB2_SISYPBPRBRIDGE)) {
-       SiS_SetReg(SISPART2, 0x4d, (backupP2_4d | 0x10));
-       SiS_DDC2Delay(&ivideo->SiS_Pr, 0x2000);
-       if((result = SISDoSense(ivideo, svhs, 0x0604))) {
-          if((result = SISDoSense(ivideo, cvbs, 0x0804))) {
-	     printk(KERN_INFO "%s %s YPbPr component output\n", stdstr, tvstr);
-	     SiS_SetRegOR(SISCR, 0x32, 0x80);
-	  }
-       }
-       SiS_SetReg(SISPART2, 0x4d, backupP2_4d);
-    }
-
-    SiS_SetRegAND(SISCR, 0x32, ~0x03);
-
-    if(!(ivideo->vbflags & TV_YPBPR)) {
-       if((result = SISDoSense(ivideo, svhs, svhs_c))) {
-          printk(KERN_INFO "%s %s SVIDEO output\n", stdstr, tvstr);
-	   SiS_SetRegOR(SISCR, 0x32, 0x02);
-       }
-       if((biosflag & 0x02) || (!result)) {
-          if(SISDoSense(ivideo, cvbs, cvbs_c)) {
-	     printk(KERN_INFO "%s %s COMPOSITE output\n", stdstr, tvstr);
-	     SiS_SetRegOR(SISCR, 0x32, 0x01);
-          }
-       }
-    }
-
-    SISDoSense(ivideo, 0, 0);
-
-    SiS_SetReg(SISPART2, 0x00, backupP2_00);
-    SiS_SetReg(SISPART4, 0x0d, backupP4_0d);
-    SiS_SetReg(SISSR, 0x1e, backupSR_1e);
-
-    if(ivideo->vbflags2 & VB2_30xCLV) {
-	biosflag = SiS_GetReg(SISPART2, 0x00);
-       if(biosflag & 0x20) {
-          for(myflag = 2; myflag > 0; myflag--) {
-	     biosflag ^= 0x20;
-	     SiS_SetReg(SISPART2, 0x00, biosflag);
-	  }
-       }
-    }
-
-    SiS_SetReg(SISPART2, 0x00, backupP2_00);
+	u8 backupP4_0d, backupP2_00, backupP2_4d, backupSR_1e, biosflag = 0;
+	u16 svhs = 0, svhs_c = 0;
+	u16 cvbs = 0, cvbs_c = 0;
+	u16 vga2 = 0, vga2_c = 0;
+	int myflag, result;
+	char stdstr[] = "sisfb: Detected";
+	char tvstr[]  = "TV connected to";
+
+	if (ivideo->vbflags2 & VB2_301) {
+		svhs = 0x00b9; cvbs = 0x00b3; vga2 = 0x00d1;
+		myflag = SiS_GetReg(SISPART4, 0x01);
+		if (myflag & 0x04) {
+			svhs = 0x00dd; cvbs = 0x00ee; vga2 = 0x00fd;
+		}
+	} else if (ivideo->vbflags2 & (VB2_301B | VB2_302B)) {
+		svhs = 0x016b; cvbs = 0x0174; vga2 = 0x0190;
+	} else if (ivideo->vbflags2 & (VB2_301LV | VB2_302LV)) {
+		svhs = 0x0200; cvbs = 0x0100;
+	} else if (ivideo->vbflags2 & (VB2_301C | VB2_302ELV | VB2_307T | VB2_307LV)) {
+		svhs = 0x016b; cvbs = 0x0110; vga2 = 0x0190;
+	} else
+		return;
+
+	vga2_c = 0x0e08; svhs_c = 0x0404; cvbs_c = 0x0804;
+	if (ivideo->vbflags & (VB2_301LV | VB2_302LV | VB2_302ELV | VB2_307LV)) {
+		svhs_c = 0x0408; cvbs_c = 0x0808;
+	}
+
+	biosflag = 2;
+	if (ivideo->haveXGIROM) {
+		biosflag = ivideo->bios_abase[0x58] & 0x03;
+	} else if (ivideo->newrom) {
+		if (ivideo->bios_abase[0x5d] & 0x04)
+			biosflag |= 0x01;
+	} else if (ivideo->sisvga_engine == SIS_300_VGA) {
+		if (ivideo->bios_abase)
+			biosflag = ivideo->bios_abase[0xfe] & 0x03;
+	}
+
+	if (ivideo->chip == SIS_300) {
+		myflag = SiS_GetReg(SISSR, 0x3b);
+		if (!(myflag & 0x01))
+			vga2 = vga2_c = 0;
+	}
+
+	if (!(ivideo->vbflags2 & VB2_SISVGA2BRIDGE))
+		vga2 = vga2_c = 0;
+
+	backupSR_1e = SiS_GetReg(SISSR, 0x1e);
+	SiS_SetRegOR(SISSR, 0x1e, 0x20);
+
+	backupP4_0d = SiS_GetReg(SISPART4, 0x0d);
+	if (ivideo->vbflags2 & VB2_30xC)
+		SiS_SetRegANDOR(SISPART4, 0x0d, ~0x07, 0x01);
+	else
+		SiS_SetRegOR(SISPART4, 0x0d, 0x04);
+
+	SiS_DDC2Delay(&ivideo->SiS_Pr, 0x2000);
+
+	backupP2_00 = SiS_GetReg(SISPART2, 0x00);
+	SiS_SetReg(SISPART2, 0x00, ((backupP2_00 | 0x1c) & 0xfc));
+
+	backupP2_4d = SiS_GetReg(SISPART2, 0x4d);
+	if (ivideo->vbflags2 & VB2_SISYPBPRBRIDGE)
+		SiS_SetReg(SISPART2, 0x4d, (backupP2_4d & ~0x10));
+
+	if (!(ivideo->vbflags2 & VB2_30xCLV))
+		SISDoSense(ivideo, 0, 0);
+
+	SiS_SetRegAND(SISCR, 0x32, ~0x14);
+
+	if (vga2_c || vga2) {
+		if (SISDoSense(ivideo, vga2, vga2_c)) {
+			if (biosflag & 0x01) {
+				printk(KERN_INFO "%s %s SCART output\n", stdstr, tvstr);
+				SiS_SetRegOR(SISCR, 0x32, 0x04);
+			} else {
+				printk(KERN_INFO "%s secondary VGA connection\n", stdstr);
+				SiS_SetRegOR(SISCR, 0x32, 0x10);
+			}
+		}
+	}
+
+	SiS_SetRegAND(SISCR, 0x32, 0x3f);
+
+	if (ivideo->vbflags2 & VB2_30xCLV)
+		SiS_SetRegOR(SISPART4, 0x0d, 0x04);
+
+	if ((ivideo->sisvga_engine == SIS_315_VGA) && (ivideo->vbflags2 & VB2_SISYPBPRBRIDGE)) {
+		SiS_SetReg(SISPART2, 0x4d, (backupP2_4d | 0x10));
+		SiS_DDC2Delay(&ivideo->SiS_Pr, 0x2000);
+		result = SISDoSense(ivideo, svhs, 0x0604);
+		if (result) {
+			result = SISDoSense(ivideo, cvbs, 0x0804);
+			if (result) {
+				printk(KERN_INFO "%s %s YPbPr component output\n", stdstr, tvstr);
+				SiS_SetRegOR(SISCR, 0x32, 0x80);
+			}
+		}
+		SiS_SetReg(SISPART2, 0x4d, backupP2_4d);
+	}
+
+	SiS_SetRegAND(SISCR, 0x32, ~0x03);
+
+	if (!(ivideo->vbflags & TV_YPBPR)) {
+		result = SISDoSense(ivideo, svhs, svhs_c);
+		if (result) {
+			printk(KERN_INFO "%s %s SVIDEO output\n", stdstr, tvstr);
+			SiS_SetRegOR(SISCR, 0x32, 0x02);
+		}
+		if ((biosflag & 0x02) || (!result)) {
+			if (SISDoSense(ivideo, cvbs, cvbs_c)) {
+				printk(KERN_INFO "%s %s COMPOSITE output\n", stdstr, tvstr);
+				SiS_SetRegOR(SISCR, 0x32, 0x01);
+			}
+		}
+	}
+
+	SISDoSense(ivideo, 0, 0);
+
+	SiS_SetReg(SISPART2, 0x00, backupP2_00);
+	SiS_SetReg(SISPART4, 0x0d, backupP4_0d);
+	SiS_SetReg(SISSR, 0x1e, backupSR_1e);
+
+	if (ivideo->vbflags2 & VB2_30xCLV) {
+		biosflag = SiS_GetReg(SISPART2, 0x00);
+		if (biosflag & 0x20) {
+			for (myflag = 2; myflag > 0; myflag--) {
+				biosflag ^= 0x20;
+				SiS_SetReg(SISPART2, 0x00, biosflag);
+			}
+		}
+	}
+
+	SiS_SetReg(SISPART2, 0x00, backupP2_00);
 }
 
 /* Determine and detect attached TV's on Chrontel */
 static void SiS_SenseCh(struct sis_video_info *ivideo)
 {
 #if defined(CONFIG_FB_SIS_300) || defined(CONFIG_FB_SIS_315)
-    u8 temp1, temp2;
-    char stdstr[] = "sisfb: Chrontel: Detected TV connected to";
+	u8 temp1, temp2;
+	char stdstr[] = "sisfb: Chrontel: Detected TV connected to";
 #endif
 #ifdef CONFIG_FB_SIS_300
-    unsigned char test[3];
-    int i;
+	unsigned char test[3];
+	int i;
 #endif
 
-    if(ivideo->chip < SIS_315H) {
+	if (ivideo->chip < SIS_315H) {
 
 #ifdef CONFIG_FB_SIS_300
-       ivideo->SiS_Pr.SiS_IF_DEF_CH70xx = 1;		/* Chrontel 700x */
-       SiS_SetChrontelGPIO(&ivideo->SiS_Pr, 0x9c);	/* Set general purpose IO for Chrontel communication */
-       SiS_DDC2Delay(&ivideo->SiS_Pr, 1000);
-       temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x25);
-       /* See Chrontel TB31 for explanation */
-       temp2 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x0e);
-       if(((temp2 & 0x07) == 0x01) || (temp2 & 0x04)) {
-	  SiS_SetCH700x(&ivideo->SiS_Pr, 0x0e, 0x0b);
-	  SiS_DDC2Delay(&ivideo->SiS_Pr, 300);
-       }
-       temp2 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x25);
-       if(temp2 != temp1) temp1 = temp2;
-
-       if((temp1 >= 0x22) && (temp1 <= 0x50)) {
-	   /* Read power status */
-	   temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x0e);
-	   if((temp1 & 0x03) != 0x03) {
-		/* Power all outputs */
-		SiS_SetCH700x(&ivideo->SiS_Pr, 0x0e,0x0b);
-		SiS_DDC2Delay(&ivideo->SiS_Pr, 300);
-	   }
-	   /* Sense connected TV devices */
-	   for(i = 0; i < 3; i++) {
-	       SiS_SetCH700x(&ivideo->SiS_Pr, 0x10, 0x01);
-	       SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	       SiS_SetCH700x(&ivideo->SiS_Pr, 0x10, 0x00);
-	       SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	       temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x10);
-	       if(!(temp1 & 0x08))       test[i] = 0x02;
-	       else if(!(temp1 & 0x02))  test[i] = 0x01;
-	       else                      test[i] = 0;
-	       SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	   }
+		ivideo->SiS_Pr.SiS_IF_DEF_CH70xx = 1;	/* Chrontel 700x */
+		/* Set general purpose IO for Chrontel communication */
+		SiS_SetChrontelGPIO(&ivideo->SiS_Pr, 0x9c);
+		SiS_DDC2Delay(&ivideo->SiS_Pr, 1000);
+		temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x25);
+		/* See Chrontel TB31 for explanation */
+		temp2 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x0e);
+		if (((temp2 & 0x07) == 0x01) || (temp2 & 0x04)) {
+			SiS_SetCH700x(&ivideo->SiS_Pr, 0x0e, 0x0b);
+			SiS_DDC2Delay(&ivideo->SiS_Pr, 300);
+		}
+		temp2 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x25);
+		if (temp2 != temp1)
+			temp1 = temp2;
+
+		if ((temp1 >= 0x22) && (temp1 <= 0x50)) {
+			/* Read power status */
+			temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x0e);
+			if ((temp1 & 0x03) != 0x03) {
+				/* Power all outputs */
+				SiS_SetCH700x(&ivideo->SiS_Pr, 0x0e, 0x0b);
+				SiS_DDC2Delay(&ivideo->SiS_Pr, 300);
+			}
+			/* Sense connected TV devices */
+			for (i = 0; i < 3; i++) {
+				SiS_SetCH700x(&ivideo->SiS_Pr, 0x10, 0x01);
+				SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+				SiS_SetCH700x(&ivideo->SiS_Pr, 0x10, 0x00);
+				SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+				temp1 = SiS_GetCH700x(&ivideo->SiS_Pr, 0x10);
+
+				if (!(temp1 & 0x08))
+					test[i] = 0x02;
+				else if (!(temp1 & 0x02))
+					test[i] = 0x01;
+				else
+					test[i] = 0;
+				SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+			}
 
-	   if(test[0] == test[1])      temp1 = test[0];
-	   else if(test[0] == test[2]) temp1 = test[0];
-	   else if(test[1] == test[2]) temp1 = test[1];
-	   else {
-		printk(KERN_INFO
-			"sisfb: TV detection unreliable - test results varied\n");
-		temp1 = test[2];
-	   }
-	   if(temp1 == 0x02) {
-		printk(KERN_INFO "%s SVIDEO output\n", stdstr);
-		ivideo->vbflags |= TV_SVIDEO;
-		SiS_SetRegOR(SISCR, 0x32, 0x02);
-		SiS_SetRegAND(SISCR, 0x32, ~0x05);
-	   } else if (temp1 == 0x01) {
-		printk(KERN_INFO "%s CVBS output\n", stdstr);
-		ivideo->vbflags |= TV_AVIDEO;
-		SiS_SetRegOR(SISCR, 0x32, 0x01);
-		SiS_SetRegAND(SISCR, 0x32, ~0x06);
-	   } else {
-		SiS_SetCH70xxANDOR(&ivideo->SiS_Pr, 0x0e, 0x01, 0xF8);
-		SiS_SetRegAND(SISCR, 0x32, ~0x07);
-	   }
-       } else if(temp1 == 0) {
-	  SiS_SetCH70xxANDOR(&ivideo->SiS_Pr, 0x0e, 0x01, 0xF8);
-	  SiS_SetRegAND(SISCR, 0x32, ~0x07);
-       }
-       /* Set general purpose IO for Chrontel communication */
-       SiS_SetChrontelGPIO(&ivideo->SiS_Pr, 0x00);
+			if (test[0] == test[1])
+				temp1 = test[0];
+			else if (test[0] == test[2])
+				temp1 = test[0];
+			else if (test[1] == test[2])
+				temp1 = test[1];
+			else {
+				printk(KERN_INFO
+				       "sisfb: TV detection unreliable - test results varied\n");
+				temp1 = test[2];
+			}
+
+			if (temp1 == 0x02) {
+				printk(KERN_INFO "%s SVIDEO output\n", stdstr);
+				ivideo->vbflags |= TV_SVIDEO;
+				SiS_SetRegOR(SISCR, 0x32, 0x02);
+				SiS_SetRegAND(SISCR, 0x32, ~0x05);
+			} else if (temp1 == 0x01) {
+				printk(KERN_INFO "%s CVBS output\n", stdstr);
+				ivideo->vbflags |= TV_AVIDEO;
+				SiS_SetRegOR(SISCR, 0x32, 0x01);
+				SiS_SetRegAND(SISCR, 0x32, ~0x06);
+			} else {
+				SiS_SetCH70xxANDOR(&ivideo->SiS_Pr, 0x0e, 0x01, 0xF8);
+				SiS_SetRegAND(SISCR, 0x32, ~0x07);
+			}
+		} else if (temp1 == 0) {
+			SiS_SetCH70xxANDOR(&ivideo->SiS_Pr, 0x0e, 0x01, 0xF8);
+			SiS_SetRegAND(SISCR, 0x32, ~0x07);
+		}
+		/* Set general purpose IO for Chrontel communication */
+		SiS_SetChrontelGPIO(&ivideo->SiS_Pr, 0x00);
 #endif
 
-    } else {
+	} else {
 
 #ifdef CONFIG_FB_SIS_315
-	ivideo->SiS_Pr.SiS_IF_DEF_CH70xx = 2;		/* Chrontel 7019 */
-	temp1 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x49);
-	SiS_SetCH701x(&ivideo->SiS_Pr, 0x49, 0x20);
-	SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	temp2 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x20);
-	temp2 |= 0x01;
-	SiS_SetCH701x(&ivideo->SiS_Pr, 0x20, temp2);
-	SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	temp2 ^= 0x01;
-	SiS_SetCH701x(&ivideo->SiS_Pr, 0x20, temp2);
-	SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
-	temp2 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x20);
-	SiS_SetCH701x(&ivideo->SiS_Pr, 0x49, temp1);
-	temp1 = 0;
-	if(temp2 & 0x02) temp1 |= 0x01;
-	if(temp2 & 0x10) temp1 |= 0x01;
-	if(temp2 & 0x04) temp1 |= 0x02;
-	if( (temp1 & 0x01) && (temp1 & 0x02) ) temp1 = 0x04;
-	switch(temp1) {
-	case 0x01:
-	     printk(KERN_INFO "%s CVBS output\n", stdstr);
-	     ivideo->vbflags |= TV_AVIDEO;
-	     SiS_SetRegOR(SISCR, 0x32, 0x01);
-	     SiS_SetRegAND(SISCR, 0x32, ~0x06);
-	     break;
-	case 0x02:
-	     printk(KERN_INFO "%s SVIDEO output\n", stdstr);
-	     ivideo->vbflags |= TV_SVIDEO;
-	     SiS_SetRegOR(SISCR, 0x32, 0x02);
-	     SiS_SetRegAND(SISCR, 0x32, ~0x05);
-	     break;
-	case 0x04:
-	     printk(KERN_INFO "%s SCART output\n", stdstr);
-	     SiS_SetRegOR(SISCR, 0x32, 0x04);
-	     SiS_SetRegAND(SISCR, 0x32, ~0x03);
-	     break;
-	default:
-	     SiS_SetRegAND(SISCR, 0x32, ~0x07);
-	}
+		ivideo->SiS_Pr.SiS_IF_DEF_CH70xx = 2;		/* Chrontel 7019 */
+		temp1 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x49);
+		SiS_SetCH701x(&ivideo->SiS_Pr, 0x49, 0x20);
+		SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+		temp2 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x20);
+		temp2 |= 0x01;
+
+		SiS_SetCH701x(&ivideo->SiS_Pr, 0x20, temp2);
+		SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+		temp2 ^= 0x01;
+
+		SiS_SetCH701x(&ivideo->SiS_Pr, 0x20, temp2);
+		SiS_DDC2Delay(&ivideo->SiS_Pr, 0x96);
+		temp2 = SiS_GetCH701x(&ivideo->SiS_Pr, 0x20);
+		SiS_SetCH701x(&ivideo->SiS_Pr, 0x49, temp1);
+		temp1 = 0;
+
+		if (temp2 & 0x02)
+			temp1 |= 0x01;
+		if (temp2 & 0x10)
+			temp1 |= 0x01;
+		if (temp2 & 0x04)
+			temp1 |= 0x02;
+		if ((temp1 & 0x01) && (temp1 & 0x02))
+			temp1 = 0x04;
+
+		switch (temp1) {
+		case 0x01:
+			printk(KERN_INFO "%s CVBS output\n", stdstr);
+			ivideo->vbflags |= TV_AVIDEO;
+			SiS_SetRegOR(SISCR, 0x32, 0x01);
+			SiS_SetRegAND(SISCR, 0x32, ~0x06);
+			break;
+		case 0x02:
+			printk(KERN_INFO "%s SVIDEO output\n", stdstr);
+			ivideo->vbflags |= TV_SVIDEO;
+			SiS_SetRegOR(SISCR, 0x32, 0x02);
+			SiS_SetRegAND(SISCR, 0x32, ~0x05);
+			break;
+		case 0x04:
+			printk(KERN_INFO "%s SCART output\n", stdstr);
+			SiS_SetRegOR(SISCR, 0x32, 0x04);
+			SiS_SetRegAND(SISCR, 0x32, ~0x03);
+			break;
+		default:
+			SiS_SetRegAND(SISCR, 0x32, ~0x07);
+		}
 #endif
-    }
+	}
 }
 
 static void sisfb_get_VB_type(struct sis_video_info *ivideo)
-- 
2.20.1.7.g153144c

