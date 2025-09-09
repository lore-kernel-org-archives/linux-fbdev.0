Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9271C683;
	Tue,  9 Sep 2025 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397786; cv=none; b=ThZPpC6QSnFMvITqr+nm5aWlmdyXRFrcclVB7PdbaS/eM30pvvJRnS0cniPugVINyN8jZxZ01ssr9+vTwGvtPLEP66wd1fsMX+fvM3EVnM5yRmXSAPV7gI0yA7LUHYO0DSgPKX6bPAm0L+ZirsoB1EH6R3TJ+mgoGgJSBlYKxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397786; c=relaxed/simple;
	bh=1mv0aNBNacoR8Z3k1QWoVR0SCJGhdYSQQ+8O3o2QeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnHnt3iPMPCX6V3M7nVYtK10aYWi8nzfqHoyZ2mvskEYH6fiDcvJyFvMxJ2v/fJCEybKpSCglvoOoRdKgAEqBiUBdYPA7w0yvciaSKaigGvGo2E6NqbaSt1QEqlk47bxMjoZ1NXaw2cQICL646L0U262CtWslWIWsv5Jz9W6U/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgHBE22u; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgHBE22u"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-327ae052173so3404371a91.0;
        Mon, 08 Sep 2025 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757397784; x=1758002584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMTAsIx4EXrT2ijx0IpLSYA8rxhXY+w0cxt7phZoGjs=;
        b=WgHBE22uNZ9k6x34GM8eUvxtpoyafkGpQtuiWpqHG1spew9tMYQjPYZKej8Qiw55SC
         ZQ0d9xZZkKFWYIlh964I/oeW8L6bjsCFnYIEz0tGTYPFgBoBP4IRREVEmbMl2s9SdY54
         sjaQ5U3DbKIF+GMm8iVgtJYGRV40FMuLK9/Qto8ZsesQSkfeVU5INJWulQlCbB91QfG8
         GH2rPbcudIArLtiHL7yzRJqk+LuN7DtTAF5SzOb+JYvSyowk+80+IEm6tS1USZ2kbePQ
         POgoEYDCceNZVCT8u8FfwOBaepWSq6VWh38BRqInViDVgewMlLyY0UdliDravKeyXeua
         /p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757397784; x=1758002584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMTAsIx4EXrT2ijx0IpLSYA8rxhXY+w0cxt7phZoGjs=;
        b=O/KGALbTOe5qc34oc0JfSkkOgBgwHRvLRaEe5N8Vn9t8+2+XLrYsWTneuJ5q08yKie
         TDu0CokmKq0GGQ0GI7+xSg5xzSI6g6brIRfXZ0/qH5TBRktQial4dX6CSBoWQRJwprNi
         2XGpVp8sWeRjivyjVttm9WDJRj7+4aJlCTzH/C4HqF6qz284XbQUnXdS6jtsmkVlZZf5
         ESDi4mHcQBIbNJqMq/dOEsrAsth6SnjEpg3aLZiJGPfym8BiH2QU5Tfv5aSzFiYVfXM3
         MzY6Tnz6781B8L6z5AvDMwbvmvxkYL/tTGkzxTcoZQvdgC7gxK1AP+46OMgR6IMI6s8f
         XJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUzAJ4ROv8W4wPHScsEQjI7RmhsWJyxtZXMVTDhPt2TWO9AgMxCpgHJtI3fX+XJ7/0UcYncJMGZiwx6tA==@vger.kernel.org, AJvYcCXWgz/y6rlyH64iWvjKskC0XSQ0MdFIKifV32bToZJWEpSSITpyZvjm+mrdlLSMNeC96Qzx1bTv7Ql0KYPx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0PaslML3+kdocR8i5qBHjHPP3VDFntsUWGSVhQuptgyd1R0C
	7H0GafOZ55WbCbWbMRrvZny+TMLZ4Au38rNaO3yZNP+nsrvZwfnJTOsK
X-Gm-Gg: ASbGncuOjKNNY66mMXsupwBs/CbT2z+qSm35xRkjb1/TxVvcJsdp0uOgUhFS0qxdnuH
	vacG8gjoSfiD0VhIbNk58ka49+yYhi18ygubQv7JshYg6a+A+yHhWv4weLPrY918Mkqt8B5Lgo2
	bKojbDDSP03Q9t1vsJ+VqU9HJWuY4uq+BqhMwx9584q0BpGoG106rbPtCfqrTAP2pqwQw7ebgNn
	AUkyG0Q9D7J7iqbfOhmKk63IV+I0IeZkyjDO/7YifVIOvC/RQyzE2Ea/yA58SxVICrWVAFVi8kG
	n10CthX85z7zbi35tUPEAxD1OuLwPDST059FJmYmKuHWtxqvhr5nEWJhjvK9oeudA+qdqivPsAa
	CkLIs6qpm5DMV7cFxuWWYY97h59TsnrNGHPeCBD9TPg/HJUAo1Df8eKAlLj4IUk4oBPDxuiqwPB
	dUIzWokPupALPZ
X-Google-Smtp-Source: AGHT+IFJBO3xDoLj4DlYD8W4yc5VM+vGGJ5bvgBXCAj3dFstVJS+RDiOm5nuaXCn8SgmgAj0jpnn2Q==
X-Received: by 2002:a17:90b:3fcb:b0:32b:bac7:5a41 with SMTP id 98e67ed59e1d1-32d43f8e8a7mr14198668a91.37.1757397783936;
        Mon, 08 Sep 2025 23:03:03 -0700 (PDT)
Received: from klmny09 (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d69bd489csm6938561a91.17.2025.09.08.23.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:03:03 -0700 (PDT)
From: Yiming Qian <qianym1996@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	qianym1996@gmail.com,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Subject: [PATCH v2 0/2] fix coding style issues in sm750.h
Date: Tue,  9 Sep 2025 14:01:28 +0800
Message-ID: <20250909060130.12919-1-qianym1996@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aL5tjv_2YkvHPs5C@stanley.mountain>
References: <aL5tjv_2YkvHPs5C@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix volatile and camelCase issues in coding style:

changes in v2:
- Split single patch into two separate patches as suggested


Yiming Qian (2):
  staging: sm750fb: remove unnecessary volatile qualifiers
  staging: sm750fb: rename snake case variables

 drivers/staging/sm750fb/sm750.h       | 6 +++---
 drivers/staging/sm750fb/sm750_accel.c | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0

