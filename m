From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [Linux-fbdev-users] Card's view of framebuffer offset into userspace?
Date: Mon, 15 Jul 2002 02:02:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020715000214.GD11998@ppc.vc.cvut.cz>
References: <20020714161029.A24172@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020714161029.A24172@sci.fi>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: syrjala@sci.fi
Cc: linux-fbdev-users@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net

On Sun, Jul 14, 2002 at 04:10:29PM +0300, Ville Syrj=E4l=E4 wrote:
> Is there a way to ge the framebuffer offset to userspace? I hacked
> DirectFB to draw to the crtc2 display but currently I've had to hardcod=
e
> the framebuffer offset. So I need something I can feed to tmy G400.

In what environment? With matroxfb you have special framebuffer which
is displayed by CRTC2 engine. Offset is not explicitly exported, but
if you'll take low 24 bits from fb_start, you'll get offset on
G400/G450/G550 devices.

Accessing CRTC2's memory through primary head's framebuffer is not
supported.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
