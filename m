From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Wed, 29 Jun 2016 08:31:46 +0000
Subject: Re: [RFC PATCH kernel] Revert "fbcon: use the cursor blink interval provided by vt"
Message-Id: <1467189106.20278.223.camel@au1.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467188352-5580-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1467188352-5580-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, 2016-06-29 at 18:29 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2016-06-29 at 18:19 +1000, Alexey Kardashevskiy wrote:
> > This is rather a bugreport than actual revert but nevertheless.
> >=20
> > Since 27a4c827c34a I started noticing weird traces and quite often
> > I could not boot my test machine which is POWER8 box with AST video
> > or ATI video (video adapter type does not matter much although
> > is happens lot more often with the OpenPOWER machine which got
> > AST).
> > The system console is IPMI, not the actual video adapter.
> >=20
> > I bisected it to this:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com
> > mi
> > t/?id'a4c827c34ac4256a190cc9d24607f953c1c459
> >=20
> > For some reason which I do not understand, in
> > cursor_timer_handler(),
> > ops->cur_blink_jiffies is zero. Why can this happen? What is a
> > proper
> > fix? Thanks.
>=20
> Rings a bell... do you have=C2=A0fbcon: initialize blink interval before
> calling fb_set_par (f235f664a8afabccf863a5dee4777d2d7b676fda) ?

Also check if you have:

> Cheers,
> Ben.

