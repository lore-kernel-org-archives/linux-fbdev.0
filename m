From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 08:03:57 +0800
Message-ID: <4341C6ED.8080108@gmail.com>
References: <1128380013.8267.125.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMaI8-00080a-2N
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 17:04:20 -0700
Received: from xproxy.gmail.com ([66.249.82.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMaI5-0006Wf-Gj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 17:04:20 -0700
Received: by xproxy.gmail.com with SMTP id i28so287976wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Oct 2005 17:04:09 -0700 (PDT)
In-Reply-To: <1128380013.8267.125.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Benjamin Herrenschmidt wrote:
> Hi !
> 
> Somebody around here has access to the VESA specs ? I'm trying to figure
> out if the EDID block, at least on recent flat panels, tells us wether
> the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
> enable dithering in drivers like radeon and "nv", while if 8:8:8, we
> should not. If not enabling it on a 6 bits panel, we end up with crappy
> looking gradients, if enabling it on a 8 bits panel, we basically end up
> sending a 6 bits signal to a 8 bits panel, thus reducing the quality.
> 

The main 128-byte block of EDID version 1.x does not carry information for
that.  However, EDID version 1.3 and later support extended 128-byte blocks,
and one of them, DI-EXT may carry the information you need. Specifically,
section 3.4.5 of this doc might help:

http://www.vesa.org/public/EDID%20EXTENSIONS/DIEXT.pdf

You will still need to know how to get these extended blocks from i2c.
I think vesa's site also has public docs on how to do that.

EDID version 2 (which is 256 bytes in size) may also have that information,
but I don't know if the specs are freely available.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
