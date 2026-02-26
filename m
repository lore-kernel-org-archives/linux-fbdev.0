Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7F2EFDA1
	for <linux-fbdev@vger.kernel.org>; Thu, 26 Feb 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094732; cv=none; b=dlZov2TMfQ7ffvTCHdaMUGIc7De3STtkk2kYyNF8EVfO6Xq/BWGyimn2g39VRWshx8cBrcAu4/7I3qtQWpNIyxG4yFzB2+RuuHqAAsjOIAyoM143Lcexqyj/dRbbrkUCCr71ezcFtB4KI0a/b/hFUY1a5xutWzNhZfo/rvhhRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094732; c=relaxed/simple;
	bh=SvBtbVzSnnIxPFqeiTXs5zLXQvNtZRORQCiFTVJDUcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JABxsQqJrOax3XfKGwqmSVA+tFONwyYMLkl8CsS+IA31EE/5f8KGMQcZjyOIyQj3hPPsrjIuGbb/H+8Ju3FNIMGL3X6gtK8V9ROHBFoVEKr0/5S4bAxU9oNkUpaPHBURq0XVvLf2ziTf3bxga/N/trjrFM8maDB/xHx2okdFDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHaRLnmS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHaRLnmS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43770c94dfaso526322f8f.2
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Feb 2026 00:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772094730; x=1772699530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvBtbVzSnnIxPFqeiTXs5zLXQvNtZRORQCiFTVJDUcU=;
        b=AHaRLnmSinmj2PaxDWSo9+FsZWPZcejTi8pw3BB+ZAc3iBh1TGdznghrjLtqngBj7w
         AIEO3/EC43vJAcyLOsoy1D5/A05/zlnXJzObOY7gAdAyx+lxxmxpUSbKEzbWmqtL7FHy
         zaq2S/CkXbfAGjR1rcaVnbTynwVT0/ghCLxBaY+Kgdm68Kz+Qh67mDrFMubDvIk5d/tg
         pj6fjFD08vENREjn6lbGE3mduGXk+6Z3O6zvOPeZH+4kM7Fttvom4NhEWbzHq3pD+jFB
         cZw+2LRq2O75sTyfx060L7xvC679YEhSA0IvJU4eKM/Ap3cQXe27WMyxS9cLvGo0q7LD
         iUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094730; x=1772699530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvBtbVzSnnIxPFqeiTXs5zLXQvNtZRORQCiFTVJDUcU=;
        b=UcR4xDBOrc7jtH5M4VP5Zpq71s9GGoeOaRjyWpoZCMJg0watgzMMeBdB/5utgX97ok
         +8Kv19dn9g6/6AhbHHzza/8ZuhOXNdagQ9/z63lVnROgbjSQohz0/BjjtZ9aoAh9RZjE
         igOWNU0ygNBKtmFFs4gxNcTKH4rKBdOn5gCzFGConvGN6erf0fkguMLBRnw/B2JFNU/Z
         G0tHEkkR3p+F4OxXikPeu5JQ3sloVv9d+n2BGYMPWD5PQiRRk9+MU1cjYa9lbu/9utMB
         QtfrwTOQfhVPTRgQTM5WZuuhP1rvdF/rC7xTeIYUdUmILCOR0aaD+unLQqQMUO7fbK8J
         2Mcg==
X-Forwarded-Encrypted: i=1; AJvYcCUfXuOYVC3w1dAbczdpoavQZf0lZuChmsw6o2SckBfxPdvqMW8Y3bbgMwzCpUWdr/JCR5G7/KVWbPug8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfIPS7fB7SOLkOgq+4lsyVC1uiCeuJl93FiHPcC/Ct61yg6SD
	zoY6zVUYCNlazxzTOw0n7CzwKRoV31qdlHH/3ezofYipJ3k+PKL9sGSN
X-Gm-Gg: ATEYQzxo28+YeOP5SiyXUMLolLfASIX3CrXyk2iILiu5js8h8QleHl4PfIxpOQZ4x6e
	52iUWwkCPaTYKdWOjbqrjVU9BLk4zM3KIvqtseUGC1bmzIMt5/HVgNOEv2N6Zo6FTxSfjg82IS+
	Q1N8TC4HIfGonP2sIbcXqckzhgvCMFIyFeLTtRgBoWVUCXBJkJp6IWVFMXuTtLMu0XiETOzZseC
	wpASU79TEdvZ72Zz1fmfcjxGcSNEHJd3BurCTV1ThkKfzQdcDfDkco3o8Htdjuk+QJ/4J7yK8xU
	38dmi5LpJDH9UqqPKXoJsUaHnjG0rWBKqUvI+0T8RPJr8LdGH9dkjcQ1und9GAUj2lBHxtImnCO
	nymg+xoMuyvtJKSg/lW0gIbwiQWUDStaUef3+Em43HGDlYuCk9PD7fAxXZGGP/CMIxmCIoTSS7z
	0RLdNLdw6rN5hUHArZGR40PDoUSB/AOqeTxP/dKIo=
X-Received: by 2002:a05:6000:2dc6:b0:439:8f6f:1b2a with SMTP id ffacd0b85a97d-43997ed6d0dmr2654481f8f.4.1772094729583;
        Thu, 26 Feb 2026 00:32:09 -0800 (PST)
Received: from localhost.localdomain ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439934cc51csm7951057f8f.3.2026.02.26.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:32:09 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: fbtft: fb_ra8875: replace udelays with fsleep
Date: Thu, 26 Feb 2026 09:31:49 +0100
Message-ID: <20260226083151.186260-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZ_6QvJPZplh6xtd@smile.fi.intel.com>
References: <aZ_6QvJPZplh6xtd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy,

write_reg8_bus8() calls par->fbtftops.write(), which in this driver
resolves to write_spi(), which calls spi_sync(). Since spi_sync()
requires sleepable context, write_reg8_bus8() is transitively guaranteed
to run in non-atomic context, making fsleep() safe to use.

Best regards, Jose
