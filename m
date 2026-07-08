Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6B428859
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jul 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534414; cv=none; b=M0xRemPsbpuzsUEqP85lWHOID01XVnk4mh6wLSvyG11KIBOKFSsMJgrI+VtpL1V+fMkw8Wu8YVIpdo8H2H1ItbXSz1lNyIAbMTWHD/Mxmuq76BSk4A70D3VkdxIb4Ni14MzYcCd1c/2TGBjp22NSW5XwyM0uhHecsseWHyddf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534414; c=relaxed/simple;
	bh=mKB64eFzBwevlbfHP4GHbGCdzZzNbk41FGpjUYsfux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N13KV6sVdKh3NW09o7XSA2mrk8bAUvqLi1JvfEnS8VHlrpa3Vcj+FS8bd41z8w1QdCK8PXEHhY+XxRUCeLGGDRPuFodJenDrduH+QFtEfBuRLaNLlowxRU9LYYuGStxCBMcrP+TzA1wWjdKFE8fovYJUOs89dXeSIH8h7Z/gQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXY/JxGv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXY/JxGv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4720f3bf164so64211f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jul 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783534407; x=1784139207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=NXY/JxGvymDRFrsijRMZ9tHdf1vok229JiWLzBHZwp/af9/Y7FHShzV1p28lfGDO0P
         Zjbde5zb79XSg/jwyzfbIjMg0JbSsUD456xvuSBgfX9elPAfqtA7LRQ4E5uq5/7exmey
         EqK3Ef4oiDQgW7SogTWxwIn9DFaDCNwAlfxgMTUAGHE1yhxkzaZ+/aNgxXqr5PJhJTbk
         YJ3U/xgt0mK8BckXQ4KsDSdGzsNpqaB1DoJXAjYrfk/nUDVL5XmP9eQo6rp9dUT4uRxU
         WqEtlylEfFx/GQK85wL6RWzG+tt8Cl+7EtXP6XzSYBHRNjkC+HgLsWCbnvW7fF2s9gZo
         WeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534407; x=1784139207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=Jvv4Afp9k5/X44hkoyAdUbXhjdiR3Ji/U0jyKKlxeGd9yMtovlmJp5NlMzTsznTBkb
         2QvR9NeZU3iSd+yVy6RScHLfjWsCn2RQzOcs0SQcmSAi9Dpozj1mmCEWKMUolN8WvyEv
         ISs1xzWmtfhhDWPCih6h6sTDAtYRYFSF7A/6NWlXbdGn41TOoY0X8e/gEktREc6QSKm2
         Tdqe8chlsCTnsWgNmgc/9NcJA3/f1i4dexk6/FI2YIG5XzCWVZGdoEf7iPK/hd6KOgOk
         /VTndolfiRl4IgadIq0KypisWqWNpHzXCge1Cbtj3MKb9K+zkw/vIATuVljndhqj/NuU
         LrLw==
X-Forwarded-Encrypted: i=1; AHgh+RrYk56aWiT9Hf1DzTqPVvXLTcM74Fqg7fkzxvCdUTELiBnG/dG/5ZCoAWOFRt9HyL/mnTAUuKjrfCX+tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyak4MUPapIH6H/SUxlgQ0JILBG95AhrgeI3DFW6C0Wycu64bMA
	MzTAiYJxJEsM7nR0onk/uXBrpxh4ixfRF5o/WyTmgiyyszmsaUAitxMkx5EyZmc26E0=
X-Gm-Gg: AfdE7cmCNMcrmpcKl90de0kyxK3f7e8RGTqPLxibEeBiAgOnBGuSrJ6Be+X019ZxUpi
	T1pSFlDCY7SC5HJgE2VOqZ/1WGE5GLGuXMjrYmBVpdwI6EcAo7niTScpwyUrc/EgL6DDT3W4bPU
	LLBdMf21T1mqvOFP51sMNB+N/1I9AcMFHBxQKLNSrRtoOXGqlW4Lh4agBnRgGem8vFKlNZ5IOeV
	qRmgNtGitqK/75ubDeCN0OoFWwE/yc6Cu+t5h1uSbDX0GaDQkktkQBYscN0Viqaz+rD8ocGhpaF
	K6LARCbSDPX58jZU/N4G7Qlw9PE0l3vuCFwqnjHR8fceVtETlXto6QYdlhTB53pqqyDaPwuXlmc
	DJ94W1/JWswV+8xaF2qM3r3Fm/MJsASpdCOwRR/a2I8WQMULrEOTaYNXuaX/T72TPaPDi2qM8xR
	wJNijKcj6Hpi3D6kPW/sVEz2cgsDzce7KgVfOa4A==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837;
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, 
	Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--
