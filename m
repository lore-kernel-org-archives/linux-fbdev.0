Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF971F03F1;
	Fri, 14 Mar 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949644; cv=none; b=gXMEg+veRpRbSu6tRCAFjnp5AHQWIvwl2JIzRmHTl6pQt+ZBIym1KfT8QxP7jjhmLa26MZNBTMBHFISzhH5opfYng88kOUXS9+lNFC2sulKl4uTGQmvyAUKS+/ZjULfeHCqR6drHxejawVcBnmhmV7w2hzMegLPDPYSKduViRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949644; c=relaxed/simple;
	bh=8NNryJWTUOCQzMS4ZaWhtqLjPfoJIF72hF/ysBqBc/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QQbSPawv/SfF9DytaEajvvWAwbIBjLf3PJaND7u5L5yjh28QTDW+5HC6taCTCiZgh1xI6t9dD5R7nhhv80YmUaOhxP1yvHl17oa3WsBGaLmP4bjEYLNLB2j4HV8y4DNPzErIFxJnEJTW4Yw+ZOA/5OOf/y9IIoe2yZ8o6vhgL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+wh/Cix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+wh/Cix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2254C4CEE3;
	Fri, 14 Mar 2025 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949644;
	bh=8NNryJWTUOCQzMS4ZaWhtqLjPfoJIF72hF/ysBqBc/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e+wh/CixHJLA91AOqmSSKYc2TYYwFuRt7ltPSG4SDCadsdpgyw8QtROWYfL9moVjB
	 yUb3oad4GUPrG8Wr2vFK2Jh/uDhquL09kkDao77mLH2tnSiDivcfDf+HDiasZaov1D
	 jdkdPWjuWSz8smftOgmd3q5bdAkykUoZoNAcNOTVqS1ZTaN9u6gouErliPHIkGAj0d
	 kcRNHKdl7EU6VpSeQbJ0zhpMXxd8tZQpu5Plw12fbZdpN0EH0ROImX3BSI3VNUQlr1
	 3pIfCnEQtkFPLLYXhijLQ49pIy//zXnAJQFivgPsx0JCjkTqbELa5OVEe0YzjX/uc/
	 DJuvnXmcJAp3Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, 
 WangYuli <wangyuli@uniontech.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com, 
 niecheng1@uniontech.com, guanwentao@uniontech.com, 
 chenlinxuan@uniontech.com
In-Reply-To: <8FC39A4DC2529591+20250310045636.14329-1-wangyuli@uniontech.com>
References: <8FC39A4DC2529591+20250310045636.14329-1-wangyuli@uniontech.com>
Subject: Re: (subset) [PATCH] backlight: tdo24m: Eliminate redundant
 whitespace
Message-Id: <174194964167.3972884.12889540713439282921.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 10:54:01 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 10 Mar 2025 12:56:36 +0800, WangYuli wrote:
> The description for CONFIG_LCD_TDO24M has redundant whitespace.
> Trim it to keep the code tidy.
> 
> 

Applied, thanks!

[1/1] backlight: tdo24m: Eliminate redundant whitespace
      commit: c9fe785857fdfc780d49b60b5bb77ca21a51411b

--
Lee Jones [李琼斯]

