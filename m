Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDE23958D
	for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964293; cv=none; b=MZclklMlGYg+aTvY99fe/+6nzZ/efOUxokjjXd99McKRg5kr53PaV7+1Lk8NCsrT9GsDMocr+sIygidrELIxIT7vsNFkavjltqnz9UwMOtx0jHomJIaiwCDr8ioDUpmjiVMyaGH9vnEBnSbj+9f2SMy2AS+lc5O4dAKe7/LXnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964293; c=relaxed/simple;
	bh=ZH3kOGmDEO3gADrpfp5Lcv221yGM51+kYEM5K/9HhGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYNOaFF5NTZte9wPWfMjdHnQ7xxD0go2pNinKZ6R3LpNA0peH/Tb/mPt77QCntZYJNXzbt8sfCGDgL09iM8fKh9SW9LVc5fVdKvp2IVVgYVz34ufDEpD3ONmpkUAlB0i9aGhYV7qwflnyiqkqhLcfmnFvIXT5aeYrnhv1uo698Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5VEYc9P; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5VEYc9P"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1274204434bso5002280c88.1
        for <linux-fbdev@vger.kernel.org>; Tue, 31 Mar 2026 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774964291; x=1775569091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyvLhjVhNdQz9p6/7OsJVs/MzdJnZrYRiPF9CcTyMdI=;
        b=X5VEYc9PEfLNPrQNXhJi0FnUi4OCa2eXc+bXw6G7t/HMocu58vqQfEtVrNWMGkK6O2
         O9MyMJIaadkD7Ukrgs0ostkzGacAmJkwdu7CwrzqxlrDl19nsabG7lyRkWmmGbo3/EzO
         tGZ/uSfKEmZj55Z5e4LA1e5ooGpTaWmm3yG7PiQGX/fOOg7cWphGdSbfqmJLjZfra+Sg
         GRp+tUYiYq87ejIV4FReeXS4xdDlqtKldDvW4BY1XtJDpeNtBnKqfaWEwdYJDDmzRWj9
         4aEDXGZUuxup5VfTgh+8p4NjETEu4Tmw7SB4jcyoJqCnwtl4PNpBrFEGsim1rnBhPZoH
         Cy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964291; x=1775569091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LyvLhjVhNdQz9p6/7OsJVs/MzdJnZrYRiPF9CcTyMdI=;
        b=n1618xubrUZPH9CbWSUzIRSRSBRJf8yQhJfDjZVmo2SrvRX8eMMVul1V7eubyB6Sv7
         SQPGwvH3C+m/m3oYn9i9dLyIO9S6KaFj/w7yROhY6s4x0BHdAFWijppLxuSxMDbGqOsD
         tRrh1wx56PpCK5BHHh2iDRMZpR4gMePrqya0zh0KI9dadRmPTOKMVqvjjp0FfYYZHUXE
         XMuRU4IJX+Vsd8ujaE/dpuJlCIilsdqwKe83TYbO/PxDf+5QlM+ErPQoI3Ot+JPfcxzG
         bTZPS8GrwD52ANfSP7doSRP/Y+2REt48/tXhPKu1UX0RXjgnq6Aokegc1jZOuNZ2RSqV
         4yVA==
X-Gm-Message-State: AOJu0YyXzr4S+7dcs15zVMkoKlYP8J0ANICyyPQFhuVuEQZO4c6zW3H2
	4g4JURelCfsNuVCjOUd3bAy9XK93QGOa6aZXtSNLrWKSlZjnafo+3B+9gAS0sMxnJ30=
X-Gm-Gg: ATEYQzxlI/koCpHSt0i5aAnISvyaOZeJfnT684YJUJiFCrclaDKbe605mrTYG222TUK
	mPd0QC8c0Dbwj+ocA164B2GW28nHIZ4lmcjw1Aw4dOkN3msXpS6TBYlu31ycIE/ticPsgZbaAUw
	1qRbxamqaV0UxRC5wXE7KNPKqvwvAuDRn8a4D4+UgrWK5GjlUH8J14SKta1E4OUT8xqSb+2RK2/
	kaLFMUXjvuQKsFecL5NrTNOnof/ThW21abNBnsAo6pP/tT3nrTu3PmzGgsO+SAuooYy9kQGlHmM
	FPAFclq5cU41y7LPLdfzZrcvP7YTLSNErJB7qX6MLWdr+iTfLdJcuSWkwu804Ej9XW8ueKs4oxN
	RtkFtBqdevh8FWBn1f+EAY+JDtgVv8TeE80ToDiKqfF/WXzOyKMNpaKPga4FkxojPdtI1hMe3xc
	WVlY0OaP5uK18qChXiN1f2Q52OPpV5du0xaCpTWvaKyhPfO5OJ8Wv90rULRdth9Zg+zgEyE0Fzh
	gZ2jo2nSbUmyg==
X-Received: by 2002:a05:7022:e0a:b0:128:d396:f2ea with SMTP id a92af1059eb24-12bdde5b49amr1721883c88.11.1774964290951;
        Tue, 31 Mar 2026 06:38:10 -0700 (PDT)
Received: from localhost.localdomain (58.sub-174-193-131.myvzw.com. [174.193.131.58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12abde65313sm9642593c88.14.2026.03.31.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:38:10 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: sm750fb: constify fix_id array
Date: Tue, 31 Mar 2026 13:37:43 +0000
Message-Id: <20260331133743.18935-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331050738.1547-1-dennylin0707@gmail.com>
References: <20260331050738.1547-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the static fix_id array const-qualified so it can be placed
in read-only memory.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdf..795e9164b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fix_id[2] = {
+	static const char * const fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.34.1

