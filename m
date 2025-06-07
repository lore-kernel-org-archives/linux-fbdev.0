Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E61C5D7D;
	Sat,  7 Jun 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325808; cv=none; b=CHtdIRdHCNR94dKqRS/S7zZvUswqqGz82XQafFb15pGkqrmJtJEVly3vxf0D+5XW2wk6DoSayMSz4GsIM3kYa4e5SUXHALRXoHacP/Q/VixeOml2Ji5Anl+Tea1uzEFhld3JO6TttrySA1pntjTRzyZlYS062kOqhoDuWKGeMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325808; c=relaxed/simple;
	bh=MwlAp9KhYNyhAtslJqg0ctFSsb6F8mgJsZ7BbEeK+3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncq164SZ3GRsaVzQloCoFlTlmyXRFvGwCGo+E/Fqe2KRPU1DzD1CzwpGcvsz/Ist2tav3neYwh3QlDPzz304PylDQVc53LqXz6xaFkzrxEqVi00JwTd5JT/PVOPXpwBJaGQJB06OsUE1qvskJ50DfQO4Gkyg3tp6pGPMC6E9KpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ztj5/b; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ztj5/b"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so246116276.3;
        Sat, 07 Jun 2025 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749325806; x=1749930606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqod118D3jVEwrFCBqDSBhFWsP1/aqw+fydM9+fXVN0=;
        b=E0ztj5/bMrE/HtHoeHA9j8EXkHt5kQD4JFaz4khAd4gXRHJJmZulJx3LlRf/skbEFv
         uKVPcOQ6ufXIPtNHTw4tMLawgLSn+w2OoUJ1IsKajRutnjvWzSuXuzYGePZzKwst8HRd
         UmcwZWHqKP+9ZWi+2I5gEvLLSaKFn0uSSltJyumbrL2waJz9p+jlOjIjT3eTuR9cfOS4
         cRzoN3KXSvcu+KuOawoxYTqZIUllzUDGdvQYDiIpeEPn5x8vYlaU5/nAGFtEpYgVRSca
         jsWhae4yT/LdRk9I5mUoq1HGlGl/R00X24VLRHpebu60iWLmvQwa9n1Gs55a73DCiiAL
         5VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749325806; x=1749930606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqod118D3jVEwrFCBqDSBhFWsP1/aqw+fydM9+fXVN0=;
        b=WI6iYq6KVlppwFYVgdjDcLJhDQIOYNsdVmCOKmxznVtd/LGa3a6Nll8ZX9FgOMv6Rk
         8iKD4xu11pWFZ46beXhUz5tL9ZmXFi3cSiqNWUVUJ5wMYjfEGr46pRLhCMUYDRixI3rZ
         evJho20s17soWmqVS10F5lsVQKW+LjtDfSeMa9tmXeEv1lK1xGNLtUl9o86qUa89tugF
         CN1fkSfNTPff229DyCODFyX7fMiJO8valR4RBhs2uhQrG+Rpq1fMpm0u/uixD+i3hm3j
         elX182GchovCLpEfCAxi4n+E4gBmfeqCymkedTr5nbXNlg7eoad+vxH8tMxCDhCLQoZ/
         pgWw==
X-Forwarded-Encrypted: i=1; AJvYcCXJZJ3HA0Nz+mM/sp/tky7sxx2Yk2kFo3sjL7qbj5JFOtF9QErVQeEYXwL5RJOakw0ysp2DKM8Dg1JQj6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXh3t4F9JoyAa+59bWuVKN8DaXRGeNDtrfKHfHn+o8huUSS7qj
	KSHX9jENaoA1Q2/Sn7rgAHTZNqLwmYxP0hq2MwKVSLpmNgsP/jRP4hEm
X-Gm-Gg: ASbGncurps99tp2gCEmBzjYLLvWoqsEub2giexOSyxlmPAMkMj9uhr1070tDG/AZl67
	KlaiuVyO0REqQ2RW8fKZGqD/j6UFqRermPNub+hc6XLcarDHzZj7zaxaevEIfoDmi1mtSs/hEao
	9Cs4kqIxVRph6tqzeRPH7UgFqZ22ZNUzGUTBVA7PbrmpIq/b/+FDsiGijHAwFMtm9hDgB1m/SpE
	FQIl4uw3CNlZDJxVYeTz1RCXsDDXlsZwSO5YcHmdwVmv9yDtZrzQf6wgExWuDXSzAwHnb5NFHWO
	C6ifAwmfwRDXbRjGRav4zkRGTRJ/ReqG11h1pmqeZW+MVKRIb8GrfXRRhiT6NKmmew==
X-Google-Smtp-Source: AGHT+IGrAVOkmfywgRNZJlHdq6cUgR8Uazj/Z1eUT3SdelEKzOenCJ2XSMiEv42CZ8Eg65NFGzQY2A==
X-Received: by 2002:a05:6902:1108:b0:e81:843e:ea27 with SMTP id 3f1490d57ef6-e81a21ee844mr10242074276.35.1749325806188;
        Sat, 07 Jun 2025 12:50:06 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81a41a48ddsm1253851276.49.2025.06.07.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 12:50:05 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex Guo <alexguo1023@gmail.com>
Subject: [PATCH] fbdev: pm3fb: Fix potential divide by zero
Date: Sat,  7 Jun 2025 15:49:59 -0400
Message-Id: <20250607194959.2457473-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

variable var->pixclock can be set by user. In case it equals to
 zero, divide by zero would occur in pm3fb_check_var. Similar
crashes have happened in other fbdev drivers. There is no check
and modification on var->pixclock along the call chain to
pm3fb_check_var. So we fix this by checking whether 'pixclock'
is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/pm3fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 6e55e42514d6..d9b3f1937ce6 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -998,6 +998,9 @@ static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		return -EINVAL;
 	}
 
+	if (!var->pixclock)
+		return -EINVAL;
+		
 	if (PICOS2KHZ(var->pixclock) > PM3_MAX_PIXCLOCK) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
-- 
2.34.1

