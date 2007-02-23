From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Fri, 23 Feb 2007 14:34:15 +0100
Message-ID: <cb7bb73a0702230534o4e2c7e9frd5f2b05accf18c05@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org> <1172101406.4217.16.camel@daplas>
	<cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
	<1172133646.4086.5.camel@daplas>
	<cb7bb73a0702220548s55380f7fk995726ffd349823b@mail.gmail.com>
	<1172153358.4306.17.camel@daplas>
	<cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
	<1172161290.4198.12.camel@daplas>
	<cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
	<1172187249.4279.7.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKaYz-00045C-Ki for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 05:34:17 -0800
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKaYz-0005CM-9v
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 05:34:17 -0800
Received: by nz-out-0506.google.com with SMTP id i11so803642nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 23 Feb 2007 05:34:16 -0800 (PST)
In-Reply-To: <1172187249.4279.7.camel@daplas>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos@people.it>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

On 2/23/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Thu, 2007-02-22 at 20:08 +0100, Giuseppe Bilotta wrote:
> > No, it doesn't. I've tried all the methods from 640x480 to 1600x1200,
> > and they /all/ come up snowy. This is starting to look queerer and
> > queerer. I've also tried changing vf min and max as you suggested:
>
> Before we proceed, do you agree that the patch will allow you to change
> video modes without disabling DDC support?  So this is still a valid
> fix?

You're right, I hadn't realized that. I can now access all the sizes
from 640 to 1600, so I would say the fix is valid.

> When does your display become snowy? Is the snow constant or does it
> only snow when doing heavy text operations, such as scrolling?

The snowy is constant and abundant, and it seems to be independent of
video size (640 through 1600) and screen occupation (single prompt
line to fullscreen mc session) and usage.

> I presume that X's nv driver or vesafb does not exhibit this problem?

X's nv gives a very clean display, /unless/ I load nvidiafb before: if
I modprobe nvidiafb (it's a module, and it's blacklisted precisely for
this reason), then the screen is very snowy with X's nv too.

-- 
Giuseppe "Oblomov" Bilotta

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
