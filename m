From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Two bugs in fbcon?
Date: Sat, 20 May 2006 08:30:06 +0800
Message-ID: <446E630E.9060500@gmail.com>
References: <20060515210310.GA1199@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FhFME-0000qQ-IY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 May 2006 17:30:14 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FhFME-0001TW-IW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 May 2006 17:30:14 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FhFMD-00032Q-64
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 May 2006 17:30:14 -0700
Received: by py-out-1112.google.com with SMTP id z59so1064744pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 May 2006 17:30:11 -0700 (PDT)
In-Reply-To: <20060515210310.GA1199@localhost.localdomain>
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
Cc: santiago@mail.cz

Ondrej Zajicek wrote:
> Hello
> 
> I found that in  kernel 2.6.16.16 is some very strange behavior in fbcon.
> I added some printks to some functions in fbcon and i found this:
> 
> I am on vt0, i have active vt0-vt3. When i modprobe fbcon (having fbdev
> driver inserted before), functions fbcon.c/fbcon_init() and
> fbcon.c/updatescrollmode() are called for each active vt.
> 
> Order is:
> fbcon_init(vt0)
> updatescrollmode(vt0)
> updatescrollmode(vt1)
> fbcon_init(vt1)
> updatescrollmode(vt2)
> fbcon_init(vt2)
> updatescrollmode(vt3)
> fbcon_init(vt3)
> 
> for vt1-vt3 updatescrollmode is called before fbcon_init which caused that
> associated struct display::vrows value is computed (in updatescrollmode()
> - fbcon.c:1970) from old vc->vc_rows (which is updated in fbcon_init()).
> 
> Now second strangeness - I am still on vt0 (immediately after modprobe fbcon),
> but during calls to bitblit.c/bit_cursor display structure associated with
> vt3 is used (in bitblit.c:244 - ops->p). Combined with previous strangeness
> (bad vrows values in vt1-vt3) i get cursor visible on bad row.
> 
> When i switch to another vt or switch resolution, then this is corrected 
> (next calls to bitblit.c/bit_cursor are using correct display structure.).
> 
> I don't understand fbcon enough to correct this problem (and be sure not to
> make some other :-)).
> 

Might be fixed in Linus's latest git tree.  Try applying this changeset:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1a37d5f51020b9967d4b4094f6d627d0873a6469

Tony



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
