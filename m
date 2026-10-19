Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAA1F936
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368346; cv=none; b=ic1srsIHRfexFSp0c48L+ssXqhwfkzu9JpJgd0iaxErlsYCf8D2kU0sbEjpFKA6dCs1RZdTQEjjJcuIQVqMn6Ng2Ad7TgbE9ao3vizrIYi6hQZQK0mpJ5O2zh2DOU8GgQGZ+OB/Tqtx+429Pjug3I+ywEpQcFZfETGgXVWaCrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368346; c=relaxed/simple;
	bh=ifjHrypS8OaIbgMtrNppOarqjtvx73eEWodHO2AKcL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1v229ADPGNVZqu3R8J5mHtSPCyR8ZTAWBbTHLyi67hHaz0NwY8rhWVTQIdRYDva7990GSYS/Rd/m3jK13CRVSFrm4PlkY6K97OjVwdLhVaIEnImxaRr40Ihfkc+UdDFA+9QyQmkI3svU5u+p+sfP3srxuby2g7AvUU1i718x0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDRiM2uW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDRiM2uW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so862829f8f.3
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792368343; x=1792973143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifjHrypS8OaIbgMtrNppOarqjtvx73eEWodHO2AKcL4=;
        b=EDRiM2uWmczAsjtiSfmillyQ9Q1n6zh0Y+u2vIAX8NEdaTJ0+Wmj+cPyKiuTueA7QR
         see+O6RV/pG/oUx6ZiRN23WOqjjuniDRGSypSaCN5qfhmCWBumyJsMYt4BvXgZnWDZG8
         BPRxVGxHFqV5T/z4O7+JfsjhDdZLu1OV0vFus542v7SI/NjFT1OeUZIL2O3Mrfe2niAs
         J/CXhln0TS0ycKEKPfV+XKEANpvuIwTRB0DNp3PePnzlnS8MpYu/cvQQ3X5JED5xNTsp
         Lix/omyHpgrw98MlLujZUuHBDHjTUFbn6Jqs8cFTha13U9hGRm0rAD7b1otRMGG8xuC5
         ZSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368343; x=1792973143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifjHrypS8OaIbgMtrNppOarqjtvx73eEWodHO2AKcL4=;
        b=zUwVM2hRMGwlSe/XijX27QZDelzNo0zbOf1lio3eyx5oVuhKxtRaTp+nNFTaJ4glyJ
         DnJPKPANMEFhaqRN5h5AWVdXz5niG/9h1RrhcDzt6emrlp0gqUdwuob1yToPiazIvwz8
         DM44cEIpIgorFFVzppSXtrieSMzEaz3XUIwi6/Jq9M+GYOhdoqlUB3FFtpWzV2KPxBA7
         0cVRUWTQHUIoCaN6r5JgLE5aKdWOAGuByI6lu2rAxF/Vl5CwL6Ix5HYXlduscHGIgGeW
         G73TQKrNDPectCEEJHVwjgmqAs2+HNrXPXHZnZiFjxTl+lebB/72/RsoxihwELAtg68s
         jr4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx9C3oPL/B0HFeaR1q8Gpn5qh1zcKHdy/0jve6d0Bi4Y+6E+LiXbb8C6sLwT0qrzuxUMIouxCpxITN2Nw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIrIJ6eLDgXOl5COKdOdw+WK5mBrJsNrdkhW+2o0LFHFAlYlW89
	M+XdhAQFVUptg8S9jpuhGYlls8G4Sk2FB1SiLzPXy31A8HzLlajUj65Y
X-Gm-Gg: AYBFou3za+RL74cgQnl60KSk1bulJoeZDHTIrPM4Z0zIMHYPQemyQhdmua6V2eCAehn
	t1197VWr2OdwYDsqFj5ysWhRAn70oIKhjmH9B6DlcJu+BiFLFRbJRA0KCAps41PF1sLtdla5be5
	OAqMV3/aN4L6LqQ8ggX2h7J7ZtT1m/7X6zNYG65M/c/TV/7jeaDrnYPzQ1LJ2a0RXll1evh+EKe
	cXgShjSBqsSsEvhUxU4te11NPYzKqhHVrQKVrgUxMGeiazsJ5N+/wjQBermFFqbSgdMkwBVAk0U
	AI0cV2tC5MuTEYUIoeLJjz0S3W/M9EcikzZZ3NNuoNnfkZ7GdNMGU9SCYk3x6v0SEBrIvMbByDU
	Vo07PpK0PwwOaGqQkXwPWukNN1Cg3316k6Vz9ogrrX5FpVMichkAtgm4snrT24n1lUnfFYDi/ZB
	2SsV9j9gtvBiICpFhP0XOu28PEdM3PwIYl0vCyrBajbqamrtAs8fAPWaOztL3gnRnMvwmud/4KN
	gn6ewIwxyDS2pwoDLPs4KtmjA4=
X-Received: by 2002:a05:6000:41cb:b0:48b:10c8:2181 with SMTP id ffacd0b85a97d-48e07f9a2b1mr10996069f8f.27.1792368343069;
        Sun, 18 Oct 2026 17:05:43 -0700 (PDT)
Received: from DESKTOP-0KSTGNI.localdomain ([156.213.131.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5038b8sm19923438f8f.48.2026.10.18.17.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:05:41 -0700 (PDT)
From: Temitope obabi <obabitemitope765@gmail.com>
To: gregkh@linuxfoundation.org
Cc: outreachy@lists.linux.dev,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Remove redundant zero assignments
Date: Mon, 19 Oct 2026 03:03:10 +0300
Message-ID: <20261019000443.753-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101838-oaf-bobcat-efa0@gregkh>
References: <2026101838-oaf-bobcat-efa0@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Thank you for the feedback. I understand that keeping the explicit
assignments is preferred, so I will drop this patch.

Thanks,
Temitope
