Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478731FECBA
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120963; cv=none; b=Y86t1wlNSgL+HSqUHRxpM8q8UykyQc0dNT1VSxn7qZhV7nmDLRhyLKe5mHt1loj21+IDQ07WERG8/mp7H+gf4dLerL7ALWypDWRWoUYsEDzEI1ef2GOMkC/CjGTmx+BkdkaLdIT4CLhLMBaooB40RsJWZAKk4yh8M7dFsnLNU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120963; c=relaxed/simple;
	bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFhPAWE+i3U3zyAPjK5fqvjBXu5uAwo0RLvheEZvIUB+PLvSwpgg+pszbvIP4bXFGJ+fr6eH2ma9vDnNBvP+HQJEfFy/nZKURAAp15UDxMoeqaPjqtJ7lgMvz/qOvY+pm0IsSumkp7oVQ9VbTGpALrkULx5Bvulr8SMbIXXRtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2oHSINl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2oHSINl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so11472755e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120955; x=1779725755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
        b=M2oHSINlwKp1gPlQLMH0zO1NwXeSiQAwTiQhdbEi2GE/bIiQk3xa0LCfGjo4f+25X0
         ybFwFHOOZnw+lHvA+Hbg6QRSQK7nCaXwEEJuWTIwm9dEEDaio5laxWJrLE+MMavlXcza
         T9chv2HjIIZeMpk7THG9/HaFw4Q6pkXW29L9nC7gjMVe2n+DcvixS+Fg030G0aea5RM8
         XWOWCKgGrCi8whKb7z/gNaCY3roWRSjZuQJbjlhOg479V8CemG/Cf3frrFdYZEtXfqoU
         JobSd8bZ6yj8mB9Ps/5Pn2EqFTqyvmDzOihwau6vjZiLijA/qsvQRPLo0EXuhX9jvl0G
         hmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120955; x=1779725755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TXq6OAKtTy29c2ZSYYSiFXHX6iuG3bFkK7SUcGbhSE=;
        b=Kxr2qyPNddX/J35Opo99gb1VyZp2lvBar5hAxlOb8YuYBniEAc5Y9u4sd06+l3JBEG
         fZTMBe6GE58u3Wn1bhLI8neGOZXyEf8niDzW6MkIsI3zthPVy91/IAxSz/31ywZcWmxg
         7A/W70KA5mwtFOZphPkpe26/MpeWJIW+t1GnH9V2c4jYDfAbEKaX3NfVeRhJUcVKpdDN
         doyJw9lqEdA7aHOxr6JCnXfF73Gir/FFj4IotQ9cWqNneRaR81IiJ/Wipx45MdT4nZu6
         3bmQ7jjl08XBae4w86vbrp/BCu1vqvZXwcpC4V4gXT3Vt2r11ohBS55+SE6NndQvNapJ
         bT+g==
X-Gm-Message-State: AOJu0Yy6WnlpbG7BGB1YYZeCpeHcg9sSsfDba22OYmJJs6ncuBTh5kck
	Jf0ge0ZDjgBPnFlQkyfvLknQjM3cmjLyhD8jPOV2MWC4MfXQjThtubqcKCSOIXdMzCE=
X-Gm-Gg: Acq92OH+TnSfZt8qtKzWRO5MUGo6ooHfoMXM/kiZlxNPri9b5x43V4uYwdlm0bfczec
	L0C/GilQLr4Or/UGfBfcs54mAGQ9wso25EYM2Rj3pneWLwlHqCJiMlMoYO87AU5UfWVpY/wGCJC
	h3D7Z+TcI+dQfFNgrBkJOe+JNW4evQn9GqrRiBr9irPY59DXmAM5nLGv5CaBlwambO/1jGhARvW
	Y3sVE3tyCKq1Q3kaUh+8sOo5cL/YCPJ+/lcFCx8bb+9S4WqvD89l5VDhgdIRKyly72VEGY19ADk
	CNoWOwE4Nnpkcd7DvV+Tsd/k8GYLKAqRubwyKeneV74BNs7a8tx0cyAoAM8vAFW9MFQIq2svYMV
	77IcdhwmNCFvcXtZyxqD+7lfP0Zfq9ksO4Dw3n4/WYPeizZhqVUoCyT6gcmoE2BGa+Yb/iSAQSw
	sdriSekTGT96g5KIJaDnyHM545wd1yG53X0Gw8bpyMy3u4Gwd5aut76oc=
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-48fe6de1dd2mr148159215e9.19.1779120954812;
        Mon, 18 May 2026 09:15:54 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ffed68baesm67076185e9.0.2026.05.18.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:15:54 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: sunxvr2500: replace printk with device-aware logging functions
Date: Mon, 18 May 2026 18:15:50 +0200
Message-ID: <20260518161552.574-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
References: <20260509135759.1391-1-mahmutovicrahman5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Helge,

Can you check my patches and let me know if any changes are needed?

Thanks,
Rahman Mahmutović
