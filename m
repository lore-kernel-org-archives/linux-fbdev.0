From: Julien Grall <julien.grall@citrix.com>
Date: Wed, 29 Jul 2015 11:02:50 +0000
Subject: Re: [PATCH 0/8] Use correctly the Xen memory terminologies in Linux
Message-Id: <55B8B2DA.8090900@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: xen-devel@lists.xenproject.org
Cc: ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "James E.J. Bottomley" <JBottomley@odin.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jiri Slaby <jslaby@suse.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, =?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>, Russell King <linux@arm.linux.org.uk>T

On 28/07/15 16:02, Julien Grall wrote:
> Hi all,
>=20
> This patch series aims to use the memory terminologies described in
> include/linux/mm.h [1] for Linux xen code.

I mistakenly wrote the wrong include here. It should be include/xen/mm.h
from the Xen tree:

http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommitdiff;h=E758ed14f390342=
513405dd766e874934573e6cb

Regards,

--=20
Julien Grall
