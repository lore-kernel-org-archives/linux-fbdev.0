From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix controlfb and platinumfb
	drivers
Date: 28 May 2003 14:36:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1054125376.538.1.camel@gaston>
References: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
	 <Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
	 <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from griffon.mipsys.com ([217.167.51.129] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19L0Aq-0004Hb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 May 2003 05:36:56 -0700
In-Reply-To: <16083.61404.354044.232004@nanango.paulus.ozlabs.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-05-28 at 01:08, Paul Mackerras wrote:
> James Simmons writes:
> 
> > Applied. Tho it is strnage. You shouldn't need to call fb_set_var from the 
> > driver. 
> 
> It's just convenient to use fb_set_var to get the hardware set to the
> initial mode.  Would it be better to call controlfb_check_var,
> controlfb_set_par, etc., directly?

I think we are supposed to rely on the console subsytem opening us thus
doing a set_par() with the initial var rather than doing set_var ourselves,
but I'm not too sure, I added those set_var at a time where I had incorrect
results without, we may be able to remove them by now...

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
