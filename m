Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13F2F1FF8;
	Fri, 27 Jun 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048173; cv=none; b=fH2Ok20u3kOWypIuf8qJloLyAFCa/iM+Ap9UTRq03nWgY7RfFK+WVJbTyEBe7a+gXJgdoQxk3xxs7TIgkCGx26Sz255LUMgACrDOh1huYqHt9dRA+qB9jhJ48n4tlE5NweT8gRhMsyAPtShjNhHN2RDQ1zJAVJP8wD4PVmQ7G0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048173; c=relaxed/simple;
	bh=VZowV171Nm0XistGOKs74QOrZOr6h4Rge3MCAkEFp+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWCpOBb9IYXI594cNBSgpM0mraOPBGzh4lCGtydQCctttThoAhK7xVcFOySEeiHGBv1Qm83zW8Fa5EPzrK0iMASMANwocih5WdNkRG1dEcuGw+fDr71i+2Ipo5SeZ9R02F4JRG4yPyWM0maXX6AVjjQ5InNmMVzCUDWcFjAzNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMGDOQ2a; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMGDOQ2a"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso196196b3a.2;
        Fri, 27 Jun 2025 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751048172; x=1751652972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kntk2ixuTAPii9dFKPtCKI0goZYsmp2oBVmbclFPZEg=;
        b=fMGDOQ2a2DZpXM5Gx2ooQMpa3jiVoH2EhAddEVj7i9BJ7oo5XeHbrwf0a2av2yuB3B
         /bff07/WAH0kVyUxV3yYAw4sDwqAuxPKFQS2UZ9PF2Ux09UA9uHqG1QKwti4BErZHKw2
         LsYMO+sJ9pJy0Lsb2+XVLG93CnuCaKfNsxkp6facl9eDFP6xg+aJpKbaQY7bOzyPeXQK
         QQ0n7byZ5GOFNfTH+o5ZFjugcMjyQMNX2/Q+jPMaDF+d7RB8odL/S1aOLXvarDgedw66
         4Hw+JJW9bPSrExkaNaknmCfFHVDr7hmAXafZ507B8DPWEAgc2blyeDWDhLM8wrhBFhgU
         p2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751048172; x=1751652972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kntk2ixuTAPii9dFKPtCKI0goZYsmp2oBVmbclFPZEg=;
        b=Nnsa0Le1N46D6xDV0ZKxMvl3t4Fycb5JcFdpo9keXG/T6plbTzRLUa0vq1TewjPAR0
         6eL0MibyOG79wx57R9Gbz8Gn7FGdoqkEA5iIht2DKBP46YHCm+0zln5t17bUMKSD9GaX
         XdAvMylPf43ehp2biP3tphl5QSuGLvoA8/lwboQ8urtD4Oh1WVDpGFCffWwtZJi/vK8b
         dKmXvtNchEHJSIzVt2Bp2QTlyWk5WQ3b5tivlDAz27ScRB7YblfDz3MZHWsxXYOIVJxc
         otAcqBB0ebjTIVj/mF0VPUSyVjO7DDUcqAvSYldEbOteLE3n5TaIuBckqWeU3ii8QLl3
         e6/A==
X-Forwarded-Encrypted: i=1; AJvYcCVJc4+G9UF/eo23xzRDUmAqLWx42r2RtkIKiFi5K/0xLPa1fyLBlZ7ozbDOwRCxKFZXuueRaEpdYEierg==@vger.kernel.org, AJvYcCVitzORhm6r3X1zCod83vYy8O9Lu+NStNN2BJ4bvTgeJknn4rQwOAusfdezLXb5dqML/sn7ZmxsXzPj8NQt@vger.kernel.org
X-Gm-Message-State: AOJu0YwD45O/RlE86Pc8mpT++E9Ew+AzWeEHJUiLi0JvYSVXiyVybPGT
	nFdnNTZfwwmjylp3vRwEeJ7RPGPxitaO2gIzVbpsK3BNHfQSQELzApYQ
X-Gm-Gg: ASbGncsMsoxlX/w2QcTyIdDT2lDKg7xgLZTaV069ToW8Avz3EYRfogq5An4mWeDIFEu
	AZVZpfp9s7ZbGbYlKA4OdNU1GmlEvWczoNSKfamiHL8ttqGX6eeNuW/hoLfaL9UnZ91YGYpm9p6
	h2NSsLTnkhZlAoq/sTe38DTnJ3WlXI0kSiaW8J3i9XcF1nU+Q3FiGh5J4g2pyl/UokEiP+JZFPU
	IXGqJdn4Xd2CsoiAxmqjjURDsDuKTtyPSnJgTwB5+mo8efAdIXa7E2ppDoMnaeLk0kyMEPlElJV
	oJgT6FfDxbtmoDdjle1AubzjlRrKfQna8oV6Ebpde3um9BKghBNBoSKxe0Bfx/w=
X-Google-Smtp-Source: AGHT+IGsfDuPOYSFYou4KXdl9S3Jhy/VdZYaWCldI0+7hD4gfeDCNDh3T2UzCz5JIyRObCJH/6ANUA==
X-Received: by 2002:a05:6a00:3d0a:b0:748:e8c7:5a38 with SMTP id d2e1a72fcca58-74af70469b2mr6613546b3a.23.1751048171643;
        Fri, 27 Jun 2025 11:16:11 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1cb8:b350:f061:66f3:baf1:5b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af520db66sm2648601b3a.0.2025.06.27.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:16:11 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	manish1588@gmail.com,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Subject: Re: [PATCH] staging: sm750fb: make g_fbmode[] a read-only pointer array
Date: Fri, 27 Jun 2025 23:45:58 +0530
Message-ID: <20250627181600.9814-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c8f5f917-8412-408d-9dd9-6635af8825a7@suswa.mountain>
References: <c8f5f917-8412-408d-9dd9-6635af8825a7@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dan,

Thank you for the review. You're absolutely right — changing the array to `const` breaks the assignments that follow.

I've reverted this and will send a new cleanup patch later.

Regards,  
Manish

