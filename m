From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 03 Jun 2013 06:35:16 +0000
Subject: Re: linux-next: fbdev-next inclusing
Message-Id: <20130603163516.caef44dd7c31d9b32e0ca87e@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__3_Jun_2013_16_35_16_+1000_01shmNArIUNIRTa+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130531051325.GQ19468@game.jcrosoft.org>
In-Reply-To: <20130531051325.GQ19468@game.jcrosoft.org>
To: linux-fbdev@vger.kernel.org

--Signature=_Mon__3_Jun_2013_16_35_16_+1000_01shmNArIUNIRTa+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 31 May 2013 07:13:25 +0200 Jean-Christophe PLAGNIOL-VILLARD <plagni=
oj@jcrosoft.com> wrote:
>
> 	Could you include the new fbdev -next in the linux-next please?
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/plagnioj/linux-fbdev.git f=
or-next

I have replaced Florian's tree with this one.  Let me know if you want
something different.  Also, the contacts for this tree are now:

Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
linux-fbdev@vger.kernel.org

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Mon__3_Jun_2013_16_35_16_+1000_01shmNArIUNIRTa+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRrDkkAAoJEECxmPOUX5FEfN4P/ijxPHouafmOHlLmYi0x5iXa
hIi5U1cWGQrDaIofFY/Yxu9Akp65NnAtesRRU/2jbCEj9PdwPdNRFR4FCnAA+cRG
0ILiFsGg/PPtNR4hkCXWwej1dtAHCyD92/9qmtD7NRqkYOI8UoY6BqyH7YwKMnRf
OS9CvwRlGPaqk9Dp8toc09MGGgvMnU/cuQ8J1IbVBMWb9jfO7qkOViEiihVyPVPT
49cxFbDPJd3+SX1kwcq079d30WXXeYL6/P1JaSicg+W+0BkVmMgUCmy8JWYAhARp
hjRAtdNPr5Dz/ZdbBY8ZUmRAo9jiEP9YmShDh1Qjl1MwqYcOvfK9KWm8AeMmuDsh
fzkB3MgBNo5NvrawfT3xB5gDs2Q95qx0dJ9lwH6LFVVXc22hhf/qRjxKf9jLGUTS
kAl6RmJ79ANLc3PV5pNoFwdC129+Murp6/wW3pTgeQ88ApjmjCX0csMuH65a3DHY
QgpotWsXKB3aJ4zyvQF9gxtwrpOUAUu1nQcwUueZv6H8sj2VLH1WOeOxUQQbihNa
cvGGL2A2Hv55gPVIP4XZW71a53lS14l1bp3ZF/kDaJT0R2+ZH7XoqwRSKPMzWcHr
yNhoXjk9E45MjrFnkqy0SGiA45mydLmrVcyLE5WPOP5luzgLjlu+QglkvCGJ5g92
IiUOks+iLpyP2eqIMbz8
=P48e
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Jun_2013_16_35_16_+1000_01shmNArIUNIRTa+--
