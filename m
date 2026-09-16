Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80003371897;
	Wed, 16 Sep 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574808; cv=none; b=tOUrNT3sLzsjr1f1DFpJH8280Hu00d4X21Xh9cOMo4BuQjv4uW/6LoWYvDONwMwV1QyJ8vCuXJzFzKPLL5eDZhyN4DWKgnjK7p0jAzdLuwQBUlfSBDlum35FKlgisWmFf2s/QxSc7l55iqA9cLYAsKAYRhWvpkUaAOpPgTCULMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574808; c=relaxed/simple;
	bh=qR7iTmLc17y1v1OBjcyaGKMPnxUMdtC+K/Ht+7gKa3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CGqeVISsUJi6Efb8MpbXL/WsTEFn0Mz5lYnwPrSPpxNIhG9D1uTkqCSsfE5zqgpgy/00+M1PEA3trcPbIYGPn0SCvwDpWXfgdU9Fk/ickh3yobQKAXQbUGcrmlyNHjVt/opdnoE0DgJFBgynunSwV+8G7qTMJ5dvNItgJzHZTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYzLYrHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYzLYrHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6FF1F00893;
	Wed, 16 Sep 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574807;
	bh=V6myRgIiHLsDNbx9crxJAojk3d9Ehre3Gq3ESvkVIlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bYzLYrHcAMFPKNDCGqvw3+lfn5AYdsOwr4Cbm6kGzZtkA/AxDoXGrFNRv5tECDH5o
	 xPxbiaDoJSO0e3O0eggkIHXqr0jRdHJoZQYOattwi+CtjLcIfrQYqJdrGsKjHHqzZ2
	 V2fZsJUDDQF5vXWcPLf+wQjjFuQp+ThUGre6pF0aRuCjYghuBecPghfe6hJmhszdkk
	 cKSva/GD6c4C/fNoopiezVhLm+NwR+ONzn2ky5wUQJLj+CIEvnAPrW6r5XqDcjnOhO
	 MX2OEHbI4tkAefq7EzwFh25IX75Oi3PzD6hptDWEmtCt0GZDcFFYyViXoXxYx9vvQM
	 qmq2Gi1ay9VBQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linusw@kernel.org>, Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20260904122646.32558-1-hemanth.selam@gmail.com>
References: <20260904122646.32558-1-hemanth.selam@gmail.com>
Subject: Re: (subset) [PATCH] backlight: fix typos in comments
Message-Id: <178957480517.1764874.11280971679880634341.b4-ty@b4>
Date: Wed, 16 Sep 2026 17:06:45 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 04 Sep 2026 17:56:44 +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

Applied, thanks!

[1/1] backlight: fix typos in comments
      commit: 5e1631df673f3d5355acd06263a884e00d8d007b

--
Lee Jones [李琼斯]

