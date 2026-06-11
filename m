Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559B233928;
	Thu, 11 Jun 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187216; cv=none; b=oHoqheXo6yRQWpJQ6yOck5ZEJBUfIRMsLbDAnRN/QVsmnd2GReBIW50/KhCZil82IZKvzLJoahN8td5hLissLZDUWUrHnY8QHlKXSbJsdFGe3PSEWxM2oxhHI7BLPK5uAboI2mzIsAGoR4gbAVJmQZWhVKXvRL8hqQDXsZ1+3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187216; c=relaxed/simple;
	bh=MKhmiHKK3tgcD/cHSgiMx1dQ1XBJBXKy8WE4aQ+tV2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rKgpbGTtP7p7Kpa/+IzZfvW/TZUBfMl06QW5+zSOsbFdLnLeAcEhSY1xmi//nJv+WPV0FtkftEtM68aT9AcyWoBtUxQwXzDkjTgjUyPPuhOgcP28WhIU+50qCX6Sm1TvtQ9tkxumoqH3sukO+jgFOLUzCAk9AMK8UDbIqw7cbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzi4I1Mj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzi4I1Mj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C221F00893;
	Thu, 11 Jun 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781187215;
	bh=rnZnid0isfWpGxezJrkvnlhLzk5qO1wcq8btBAN/56M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Yzi4I1MjuiSeOa8sq4OZMCdbXyeTP9Tg5xqmbyjqJeXAaLw/zZu/9pFQbyAqaTFHQ
	 GF5qf76L7YNdqTavqV69/JUXJW0x0ygHK1P8w0alVfkrtZrZ9wLut0cLHXzoZoJbXW
	 bKCwCFOwd0+FrRHQYNdMVfaRHHRPmNxzXO7ngSq4pg/vE//DBgpP1UBisQ7Q+pt1r6
	 Bd+5hyDZSdEqSk/UMe2VdjarD6bIWuy+lW4m75JysYroUtH14CZ/BdI52yNjB713DQ
	 DYy0qfbEqXePJTQyGxZ0XTKRF+1WPfFMorkTN2UlfQwGCZNpHutlmmar+jYrk+N4LF
	 BS01Ulm03oqlg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Helge Deller <deller@gmx.de>, Junjie Cao <caojunjie650@gmail.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, Flavio Suligoi <f.suligoi@asem.it>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
References: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH] backlight: Use named initializers for arrays
 of i2c_device_data
Message-Id: <178118721246.1123697.8942177075587208326.b4-ty@b4>
Date: Thu, 11 Jun 2026 15:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 18 May 2026 13:12:03 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> [...]

Applied, thanks!

[1/1] backlight: Use named initializers for arrays of i2c_device_data
      commit: b3c8bb2e69979e3aadcbfc5ac53424ecf26a9277

--
Lee Jones [李琼斯]

