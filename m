From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Sun, 09 Mar 2003 04:47:04 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E6AB938.3030003@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80	 80506@winischhofer.net>	<1047045694.1310.6.camel@localhost.localdomain>	<3E68B895.2080500@winischhof	 er.net>	<1047067923.1226.26.camel@localhost.localdomain>	<3E69065D.3090706@winischhofer.net>	<1047084988.2388.4.camel@localhost.localdomain>	<1047101983.1231.2.camel@localhost.localdomain> 	<3E69FC34.50703@winischhofer.net> <1047160870.1212.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rrlj-00025l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 19:46:35 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Antonino,
> Your example - 1024x768, yres_virtual = 1152, font = 8x16
> 
> 2 cases:  
> 
> 1. full screeen console
> vc->vc_rows = 48
> 
> p->vrows = 72 - (768/16 - 48)
> p->vrows = 72 - 0
> p->vrows = 72

You're right. I made a mistake in my calculation.

> Granted, the patch I submitted was a quickwrite, never meant to be
> applied but serves only to illustrate.  This is a more proper patch,
> applied against James latest fbdev.diff.  It simplifies the equation,
> remove the unnecessary 'if' conditional.  Apply it, don't apply it, I
> don't care.

That's not up to me to decide. For me, the only thing that counts is 
that the console can deal with text areas that are smaller than the 
screen resolution. Besides, your last sentence was certainly not 
neccessary. You among friends here.

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
