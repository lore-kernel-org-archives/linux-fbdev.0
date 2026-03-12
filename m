Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343137DEAE
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351767; cv=pass; b=VCGa1eFecxEq2fBQuF7n7wvhUj1U3RyAHPWcxx+51LOTHBu16nGzj9iLA+SMoLQoIdwc2sLn1ngxouk7P/9l96ddQqWatb0SQ4rTDlZQNREO90DtH61g6KUKH9bsLJyyaWq3mwa2w7s981a5ee+JvRmsVYfacoxrJvJk6ikphC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351767; c=relaxed/simple;
	bh=4HkSodIfBnYo6NSDQXtX616D+IzyBJtdcJTTEUNdOpk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h9nJAYwHUfpSpSyhqiEdAlJGuOCpE3ojAmI5gsQ17415WT4jDDja1+qFo7s9SkKXNeoN0os1B1V5cwgzbZjxpYIFHB0gkQPBkoijcrSuWIs0OwW9EgTFdkIW7G7HzvkiWn3nawabxnyIvRzOl5KYjxaPQ02NeiPAUtshfjJxes0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbJfh3Kl; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbJfh3Kl"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46703fb602fso662689b6e.0
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Mar 2026 14:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351764; cv=none;
        d=google.com; s=arc-20240605;
        b=K0zj5mcNeNWz4LQmXNY/kSsRhZXRtmowhJXFhFxj7om/2khBAll2+2f1pCRF3CliN9
         OLWomK7OGHGRdcONvC9RbZeSUJdfZbHRQDzHSPBsWoRPa1NrwhujRzD4/qZdnVrlk3iZ
         Xj9sZy3BW8SvDOYPzfOvLE002Th5owoIHpCKp18DB3C7jWiPdW9Ln9RGyuetUTKn+wDX
         hy5jQjL6jd/wP4L2XBUNDQReS1vi1eQoN3dka3RH1XTBzV822XD0bhgWwCF1y93dEFEU
         1UOn701QHQKXrM9xDcc4FBtZRk8utJVkUeRm4OAFOAvK/cuqo9PIiFSQpLBvHZ4xnceQ
         qVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
        fh=NKuXCkC2XL3dAvve6dwIbwjeWp5seQ7v4a/0qQHfi54=;
        b=TmO8UkNOm73DuG7PaGmpIrrB/CY8avpWCCgNjjlLlZJ7lWpmTwpyhPNu5KLD76TByn
         05zT+X1ioDXk09pakv27o8NglIVjetmtnMTwnAE84gcoIfu6fpvnn5ZK5ilDb90YyO17
         MMV4pwl+bst8vsQYyZJ1bl9LHt+90PtpoNIKK8lIZ1K0ewn1cWV7FFROtSK16r9FP855
         5hWSGgPHCqXwemy76xhnAMtOudPHlHDJ4VT8Azok/S8oPg9R1qGKFDEPN72AET44LGsO
         D0CQoZPf6lWUW+3883vCVHGaEeXwGJP6rO5RphF6GJGoVHJNTBfkY6SwjewJhha59yeH
         qf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351764; x=1773956564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
        b=kbJfh3KlwncbIHMND4T4bsg//L7JSBar5BJfYJg91NMil5ATo62q+98t492o5q35L+
         IF25PtWqE/C4owckza/SymQx8cwodFb3ppXGLifIX3zWlUsHZrhS8mICCXDrm/TYSJpF
         4lTTPQKDTcAvDeu4o8NcvWcVJ+2SJrMuWWlercf1ciHbzb947hFG669JUXJim+RQiR3t
         dDnfVA8Ugw42GLXdKgdf3YevZhY61i6HsifwC4gDL32hODKoCEpHQpfTeNqUX/BECq69
         GCwSs2Jic8GQFjKw+vuIZzc/aAxVJSWxrkMdvH6ujpPido26mrwCv8cdQjKAa4rg8gBG
         wO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351764; x=1773956564;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
        b=ZF24emuUKSzVD7lUATqWOEcqOlqX8tEyLR6Fqm+5dQsgblWyXSLkNl/4v5qRLADuaw
         El1VZXPZBI4cYnnMwqfileT4YT/h4zYtYzkiHE893jR0qPGlD30umHvRlePyrm9H/B4r
         vSqh2LL/3HpY5mMvh7eT7asPhhUCsVfrqMmm9sCZxoiNOhS6DXUFk6byUdS7eJAFKPoj
         oSFLjdfz7679wWgAzkKCB4S1H1MkEi/gTEXugBws67T3h9xtcCxGyF7wSRphrWkiQlwp
         asd/VMVqqP728wKCNMA8oeeafV2HqWw8IGKZM/Wf4IdH9HrX7WLbFTM84t+mWzbteVRx
         bOFg==
X-Forwarded-Encrypted: i=1; AJvYcCUK2BJe4xWhuoe7S+jU2/uqKcYKqJnHp/OArogP3LWUAP5JNrsHiSsZ90YPCDtbKPsT8JOGYiSxls+0jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhUTB0MY+UiianEn0XMYoXQQ7vxc88y1py9YGSgxIagdmvZNx
	38ZEPYrrEyWkDqZCvrr9BBolyTIZtbw5HBOP4xjnYGY9hj1kbHI2uNJl3/kFmGOzQVn+vOioCGC
	/9A5135MDD0tgCuQx3+2UncpFT8313PM=
X-Gm-Gg: ATEYQzwLBVBXCgLYuHhWHAhiY9q+HFnD70UFYIKBF6fwTehn1n48m5FKtXDMnAomkyS
	TMf+MLEwqryGODjO/nZWIJwzfr8F0G9H3rcYySqOK4Zc55ZrDR9hDfpaZperIRumh5NUzgOxNj1
	giIGEPYqHS/1pjB8Axs/maty0vnL0VB9EaVGG45kW/SokYjmHuQwA8NKcIJ2530YhYy4oaMGWLq
	uYFBb8LcVLUlZaCYW/loHOtSzk95DEkVS5AdsyYCzomFpuefzwni91q/Cu63bJJvKIJLgbk7Bqa
	hYCLuN5Y1YkRC9WnXpI/hiAiQ7sVPo4+iW8YbvcA4yAWNwboJov0FZSd2NkcITfeZa4IxwEN7q7
	UxoJ4
X-Received: by 2002:a05:6808:1302:b0:467:272e:896 with SMTP id
 5614622812f47-467575b0937mr476360b6e.62.1773351764539; Thu, 12 Mar 2026
 14:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John S <xaum.io@gmail.com>
Date: Thu, 12 Mar 2026 22:42:31 +0100
X-Gm-Features: AaiRm538N0gSaDCFHGWanXhFr7aTxlxi-ifUVs118JNj6Hrmu2fLSBitJItsXMA
Message-ID: <CAAZVx9_Ki2h-FGemFOhykKvWxayJ26z8ji645Vsj-fdJuH4fZg@mail.gmail.com>
Subject: [PATCH] backlight: cgbc_bl: fix kernel-doc comment for struct cgbc_bl_data
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the required 'struct cgbc_bl_data -' prefix to the kernel-doc
comment so it is properly recognized as struct documentation.

This fixes the following warning:

  drivers/video/backlight/cgbc_bl.c:29: This comment starts with
'/**', but isn't a kernel-doc comment

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 drivers/video/backlight/cgbc_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/cgbc_bl.c
b/drivers/video/backlight/cgbc_bl.c
index 9212c498e6e3..0964205ef1ab 100644
--- a/drivers/video/backlight/cgbc_bl.c
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -26,7 +26,7 @@
 #define CGBC_BL_MAX_BRIGHTNESS     100

 /**
- * CGBC backlight driver data
+ * struct cgbc_bl_data - CGBC backlight driver data
  * @dev: Pointer to the platform device
  * @cgbc: Pointer to the parent CGBC device data
  * @current_brightness: Current brightness level (0-100)
--
2.53.0
