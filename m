From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 21 Nov 2012 15:12:09 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <20121121151209.GA4048@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival> <50ACB59B.4090404@iki.fi>
 <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com>
 <20121121130039.GA12191@avionic-0098.adnet.avionic-design.de>
 <50ACD7DC.5060405@ti.com>
 <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
In-Reply-To: <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 12:02:47AM +0900, Alexandre Courbot wrote:
> Mmmm so maybe I am misinterpreting things, but it looks like we
> have just buried the power sequences here, haven't we?

I don't think so. In fact I was just starting to think that maybe for
Tegra we could have a generic panel driver which used power sequences
to abstract away the pin differences for powering up the panel. Since
most likely that will be where the differences are there is a lot of
potential to factor things out into sequences.

Perhaps what we may want to postpone for now is the DT representation
since that's what Tomi and Grant seem to be mostly opposed to.

Thierry

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrO9JAAoJEN0jrNd/PrOhsvAQAKSVMEuMUIu44H6ENIW4tAKS
XdGSSQxiv1wbXStKB+n52L652AZp+ht98aXWqhZQY7BGj/v+FOMD6tPnPaeUk8Pt
7P/q/KR8jkiG5888WwBsZ3iKtZcM5uui+3Bsn39npWDkrLJ9lb/AKxRWjMfOrGGc
SHh8/l+uigV0m217MsOqAlrEMFxRIdpRWsMUuEXvkmGoiq3Psr5qJvbDgU9ZjuCu
M7n/iP8mllBxqFEa22a9Ka9s39jo6zzFvz1CislH9HEnRsykGBNXXmmA0G4yjDAA
Gb/kegNpyRKy/dCTZuqXes3daH5ygosnluvV8wp22Wv9QjvGN6All3PzWHVEWvAA
HWGxvNFsyRA+a1yHOIQHCAORsfmoE5U3/ynG5NCaJcNDQhdtgF80hlk2t6UoFBfa
162u9k108xW+afC2OUTmWMAXJTvYBUPdfRHzQeMStudDs00KS2vSVTdHVF+Yweej
TNQcyTm6LjRVwHajc6bXtWOpw4zTrMd/QJfuSgVF4yqMMFYA0nQxHx3iYU9fkuTh
H8lBFgSxQFLAijTiTcQZg4ga7wdmWP/NDxo3ZMsORheAFG283Gmx21C7ZoxLjfkr
USWZvosHvDjBSSvZPfSK05ave+BTWHzdzMnEhdKbQ4x7vlUbBS/LDTDzAlA1F6mL
LizHf/P1c7XzZEF+iL5s
=NaXm
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
