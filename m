From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Tue, 2 Jul 2002 08:35:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020702063549.GB30388@lambda.u-strasbg.fr>
References: <3D200B7D.7436FF5F@irisa.fr> <Pine.LNX.4.44.0207010957410.21874-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PH7H-0002Ww-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 23:26:23 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207010957410.21874-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Romain Dolbeau <dolbeau@irisa.fr>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Jul 01, 2002 at 09:59:16AM -0700, James Simmons wrote:
> 
> > > still is problem with the copying of the text console data at bootup,
> > > but apart from that everything is fine.
> > >
> > > Should i send over a patch for adding it to the Config.xxx files ?
> >
> > Please send me the patch, I'll submit them for inclusion
> 
> Good news. I already included Config.help and Config.in entries for the
> PM3 driver. As a note please consider porting it over to the new fbgen

nice :)))

> api. I'm going to removal the old fbgen code soon.

how soon, and is there documentation or sample code for the changed api
?

BTW, i suppose now it will be easier to implement dual head with a dual
output board ?

Friendly,

Sven Luther
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
