From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other palette formats
Date: Tue, 03 Jul 2007 15:46:49 +0100
Message-ID: <468A6159.6000808@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200707031607.08511.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hans-J=FCrgen Koch wrote:
> This patch adds support for the other three palette formats possible with=
=20
> the PXA LCD controller. This is required on boards where an LCD is connec=
ted
> with all its 18 bits. With this patch, it's possible to use an 8-bit mode
> with 18-bit palette entries.

I've been working on getting the non-palletized 18bpp modes working and=20
had a preliminar patch that just didn't support packed mode yet (using=20
24 bits per pixel).

We can either apply this patch as is and I'll just merge my work later,=20
or I can try to merge both patches and send a single patch upstream.=20
Either way is fine by me.

For what is worth, this patch seems ok to me as is:

Acked-by: Paulo Marques <pmarques@grupopie.com>

--=20
Paulo Marques - www.grupopie.com

"Very funny Scotty. Now beam up my clothes."

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
