Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40E3A1E90;
	Wed,  4 Feb 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200789; cv=none; b=qQ7NiTZkOkas91Rq74TUNm4lH0knzopzRmMNQu3RSKmyPrSnvm2CWfsJEGHGPtRWNuQnJo32SM5ON3M6Fcb07VMNesYqYiI/1xDpQaOrgpF81jPHx8qlwuesINAypbuvkVHze7CA4bZrAUYRFDJ0NeehDT4eAefF4yLwuBWScps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200789; c=relaxed/simple;
	bh=d2ORjAFYDx26CCy9qL6CmpUxNx4yL0rMuIyF+swd47c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sFJzP1vzVEqYVEILQkPpaTs6aHmr7mvOaCrezWaH/0dK8ch7ztwZOLEepHpZLe3PFSyzd65K/XRwR2UHIRfGYoMgSxgQBONnS0XX3gtfZ8aYAXgetbz8ifJhZNTMVI5ywN054GE9VdhkgKk6WjLe4ULw248bJxxA/qg3hETa+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0XacNdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0XacNdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10194C4CEF7;
	Wed,  4 Feb 2026 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770200788;
	bh=d2ORjAFYDx26CCy9qL6CmpUxNx4yL0rMuIyF+swd47c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G0XacNdiA2sPN9bZfD51gtADbKtxQu8R/qTGNkZr4YjYt0KUY7g9bp0m6ZNanmclc
	 xKqjqGs/2VMC0xVXm5Sc7pi1K5NgSsT6oKaK0ukJeSa4Sm8cdf1HECNIergdRekhDd
	 MzJxZo+h95odzHjxCQjaVeMYWdYOUIU1aIfOBfSo1JbF6YgUjCBH31ZlIjhCB3kcEv
	 xD7TRJuUF4SpuJengb7BJeXKLzqH4Yt601kU9y7AFCqg2aSCmd+N2qVbQv46YrYAnB
	 TV3WUjV/IwbCj+f8TMSCnw4ejCN4AyKKqAHrI6Ej6KKBhYDUqpXXAOAVcSOQs7FTfP
	 lBDFotNRjA1Zw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, Helge Deller <deller@gmx.de>, 
 Luca Weiss <luca@lucaweiss.eu>, Konrad Dybcio <konradybcio@kernel.org>, 
 Eugene Lepshy <fekz115@gmail.com>, Gianluca Boiano <morf3089@gmail.com>, 
 Alejandro Tafalla <atafalla@dnyon.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Thompson <daniel.thompson@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260116-pmi8950-wled-v3-0-e6c93de84079@mainlining.org>
References: <20260116-pmi8950-wled-v3-0-e6c93de84079@mainlining.org>
Subject: Re: (subset) [PATCH v3 0/7] Fix PMI8994 WLED ovp values and more
Message-Id: <177020078282.1122108.15047767273354321830.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 10:26:22 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Fri, 16 Jan 2026 08:07:32 +0100, Barnabás Czémán wrote:
> This patch series fixes supported ovp values related to pmi8994 wled
> and set same configuration for pmi8950 wled.
> It also corrects wled related properties in xiaomi-daisy, xiaomi-land and
> in xiaomi-vince.
> 
> 

Applied, thanks!

[1/7] dt-bindings: backlight: qcom-wled: Document ovp values for PMI8994
      commit: 02031064bb8f387d81988a8abb211f1366d87582
[2/7] backlight: qcom-wled: Support ovp values for PMI8994
      commit: f29f972a6e7e3f187ea4d89b98a76c1981ca4d53
[3/7] dt-bindings: backlight: qcom-wled: Document ovp values for PMI8950
      commit: b2df6cf10d5242bfef2cc957d83738ccb560ed9f
[4/7] backlight: qcom-wled: Change PM8950 WLED configurations
      commit: 83333aa97441ba7ce32b91e8a007c72d316a1c67

--
Lee Jones [李琼斯]

