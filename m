From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge,
	updated
Date: Thu, 22 Feb 2007 09:08:25 +0800
Message-ID: <1172106505.4217.54.camel@daplas>
References: <20070209193405.GB2637@localhost.localdomain>
	<1172102733.4217.38.camel@daplas>
	<Pine.LNX.4.64.0702220049320.17121@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2Ou-0002YB-75 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:05:36 -0800
Received: from nz-out-0506.google.com ([64.233.162.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2Os-0004wk-SI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:05:36 -0800
Received: by nz-out-0506.google.com with SMTP id i11so26422nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 17:05:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702220049320.17121@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ondrej Zajicek <santiago@crfreenet.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Thu, 2007-02-22 at 00:53 +0000, James Simmons wrote:
> > > +/* image data is MSB-first, fb structure is MSB-first too */
> > > +static inline u32 expand_color(u32 c)
> > > +{
> > > +	return ((c & 1) | ((c & 2) << 7) | ((c & 4) << 14) | ((c & 8) << 21)) * 0xFF;
> > > +}
> > > +
> > > +/* s3fb_iplan_imageblit silently assumes that almost everything is 8-pixel aligned */
> > 
> > Hmn, same thing with vga16fb... Perhaps we should bring back the
> > fontwidth flag of 2.2 and 2.4 kernels.
> 
> Ug no. It is possible to get 12,6 bit width fonts working with vga 
> interleaved planes. I got it paritally working but never got back to it.
> Its in my queue of this to do. Now that I finished the display class I 
> need to get around to makeing drm/fbdev work together :-)
> 

Of course, not fontwidth exactly, but to allow the driver to specify the
alignment of the blit engine, in this case 8 pixels. I do believe X also
has similar functionality to compensate for the limitation of the
hardware.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
