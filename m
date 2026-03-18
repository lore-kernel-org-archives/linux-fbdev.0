Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23123D9043;
	Wed, 18 Mar 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841840; cv=none; b=Vr7pveeKnonLIV67mRI1ZpYrEdE/0S49ny5BOFk5Mc5gjemyU2MBfv+4Iy2+eBTUPdF5+Yqkvfp2KjZvtgeRJZE897732eaYke8eTDzB+aDw8uoQjV1xPnakOtAVGIB8yfZKMX++R2psTyTGC8+x0pf1nRqwbvVtZE70eN73Qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841840; c=relaxed/simple;
	bh=jhB3DWDEA1NFx6pzHikBFnyaa+AFvM0zZrQojID9DCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYny8evmlY8IAK6AsGXVKVhEcuaFd55Eu2aa+v666r0bAFM1zeEV1tHjccUA9EtN2fFROBmtDMnrZqirViOA5rC56supxG6J3yfxBeNeWCEZop7ApnSFdsbknDdExcVJX0+cdTcSW4N/a0ItXkWNywHazZXlzu03jka0+OvGvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btFhB8po; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btFhB8po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04547C2BCB3;
	Wed, 18 Mar 2026 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841840;
	bh=jhB3DWDEA1NFx6pzHikBFnyaa+AFvM0zZrQojID9DCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btFhB8poKI9Qb3uJjMel3dPYXQFyEI9WskA+rtp+yBagaJZXkdtWLwWBwIZ6GODaq
	 FfhnDrPptYjakbKzNQr9JtjlR0RDn6udgo64Ge6FLmhjKvwJ/eG8oFIytnvYQWBIkE
	 qwP2fQpyQHewxh74nwtLBElfRqzuqNco19p/eHlxCErA2YjIh/1biftOO5OM+w7oPu
	 o1SfdYc/4RU9CDdwyCoqL59NRjykxFdvi0JT+zIjOSZKLWlp4hGLedYqKgYnJP7vzX
	 F2TUFh3Z71vk9+Q5dFxsQ6xfIq/gMHd7oKN0oFDds94+rt+HtBe96oGyU6pc4/s4tG
	 bk8DCpOEVLn3Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kiran Gunda <quic_kgunda@quicinc.com>,
	Helge Deller <deller@gmx.de>,
	Luca Weiss <luca@lucaweiss.eu>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Eugene Lepshy <fekz115@gmail.com>,
	Gianluca Boiano <morf3089@gmail.com>,
	Alejandro Tafalla <atafalla@dnyon.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/7] Fix PMI8994 WLED ovp values and more
Date: Wed, 18 Mar 2026 08:50:04 -0500
Message-ID: <177384182881.14526.6236464092813322738.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260116-pmi8950-wled-v3-0-e6c93de84079@mainlining.org>
References: <20260116-pmi8950-wled-v3-0-e6c93de84079@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Jan 2026 08:07:32 +0100, Barnabás Czémán wrote:
> This patch series fixes supported ovp values related to pmi8994 wled
> and set same configuration for pmi8950 wled.
> It also corrects wled related properties in xiaomi-daisy, xiaomi-land and
> in xiaomi-vince.
> 
> 

Applied, thanks!

[5/7] arm64: dts: qcom: msm8953-xiaomi-vince: correct wled ovp value
      commit: 9e87f0eaadccc3fecdf3c3c0334e05694804b5f5
[6/7] arm64: dts: qcom: msm8937-xiaomi-land: correct wled ovp value
      commit: 9bc4b18a425e8cf1bca190a136a11c3be516f513
[7/7] arm64: dts: qcom: msm8953-xiaomi-daisy: fix backlight
      commit: 7131f6d909a6546329b71f2bacfdc60cb3e6020e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
