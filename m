Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706843;
	b=NIUxckRA7sDfPHTwW9JsrQ7M3y0MNFBAhmcR3EDxhA7v4H8EjI/YVhX00iKQXXc6HurC
	 8PUwh2H0hl8Oc7lWge9rXCBMHQ/lBRryNDFk7cHXPZZjwecGgkiP8qC6Or+vpyJ9+z7Ra
	 MnWHin+9a1+ragjqAHPpybsZ9Y2V6+Y2uj0MciYvjt9Gm9hzKGNlWSKnCtwb9+6hm5s9K
	 BeQNlFfJMAeHMLKbhoTyNVv6ytFB73JKnqAxz/j8byQe0/PrD3+FJCg5Ci5atWq+JcP/T
	 QJVVQsrI8TaRg0sOgccGtryJeeQ79Z3D8QP0WfXc5J9cHAcsxqdpBi3i/q2aK6TFsjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706843;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=G1wnrmAx6UKYvtzrJ7pGlQnyDEoN4L09wwQrnXzgcqk=;
	b=BMw33rQiwnMrBIKN7a/WGRYb1bntHHrWexUQJ14UPR8c6mKNcVY7JdrSCn1Mgyt6Aat7
	 u+BcmkDDLEnqJs49SQvA+Tcv384HhgUJAVr8Fcbr3Mw0n4SEeC47RyA79lvnhweL/IDmm
	 lDF22GXKNVGJN4ftyAxYKs4dmJERH5a446aZT3cM3WYz2AmagdNSxZ+hWt7HiqQiRIkb+
	 xjjrTnfjWo7JY4F4YlBj+AzQxi/AAor6Y+ONAo6DbE25QxBWPNIpnoeCX4UAXtIJPTnfq
	 f2hIdPu1XUPAAhn1f2hCEKteMahsIaj97GZJxhFNcD0on7zH16Uwcdt7vavAAgqRkxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYajrT6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2B606D805;
	Tue,  3 Nov 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYajrT6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD761F00A02;
	Tue,  3 Nov 2026 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706842;
	bh=G1wnrmAx6UKYvtzrJ7pGlQnyDEoN4L09wwQrnXzgcqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DYajrT6UnCaA2QaHVM6Oq6Ej8fHn/k+mNdjVnvuE2HH2MIfgeZpcFPRCTr7VFMFoF
	 axET584bGA77w57DX5sgiDR1LABwuFTVb/byivkS4Zlko4yqMRpbsM1fYnH3BcU16l
	 NMHcGkH2yT+wgEU2IXwVSCvKjea1lK0Gc1bNPBTXVwBqka5nUAIDv1LTCsAFoc7nGA
	 Eo93yXlNeQxgBS+ZRCuogUb5/MWbEpinwteL4sLWqdkNBomEa+QJsgvSi+VxDVmfOf
	 5Ge12PoxPGmwfFu0rOHod4zwmnJmMGvR0sCxX/iyq1jvm1n3KecYx7Vh+o88tR8vb5
	 vASUaAK2j8eRg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D84A6253A672;
	Tue, 03 Nov 2026 11:54:00 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, mfd@lists.linux.dev, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/8] arm64: qcom: enable display card
 support on SM8150 HDK
Message-Id: <179365864580.2186205.7754433993357235376.b4-ty@b4>
Date: Mon, 02 Nov 2026 22:30:45 +0000
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=broonie@kernel.org;
 h=from:subject:message-id; bh=33J6wCN/4BjmBIY6abHmDR1XKIu9W+IsNR/tzfBzFHE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeno7Qr2TfX7wqVGcWo6bhS+29a94UL7U5GvFksuvDh
 WvmJAos6yhlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBELjxn+J/j4m/sGFbi9aem
 tL3T6bnPMZPa5H4OSaebQs+827nPf2dk6NrPNnmRaXH2t8PZzitlLRllLp86oVJzz9xY3H16UUA
 8DwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 19 Oct 2026 14:25:36 +0300, Dmitry Baryshkov wrote:
> arm64: qcom: enable display card support on SM8150 HDK
> 
> The Qualcomm SM8150 HDK can be equipped with an optional display card
> having the same panel as the display card for SDM845 HDK. Reuse the
> driver submitted at [1] and enable display card support on this HDK.
> 
> Unlike SDM845, this also requires a new LCDB driver, providing voltage
> for the panel and several fixes in the WLED driver. The FSA4480 address
> fix is independent and can be applied earlier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[2/8] regulator: dt-bindings: add Qualcomm LCDB regulator
      https://git.kernel.org/broonie/regulator/c/487f55870c60
[4/8] regulator: add Qualcomm LCDB driver
      https://git.kernel.org/broonie/regulator/c/be8c26474857

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

