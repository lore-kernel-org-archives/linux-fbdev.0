From: James Simmons <jsimmons@transvirtual.com>
Subject: RE: Adding an fb_sync() operation to fb_ops
Date: Fri, 31 May 2002 13:02:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205311301430.3190-100000@www.transvirtual.com>
References: <2B4461BF89BAD511A86100508B66D53802080A35@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Dsbg-0004Hl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 13:02:40 -0700
In-Reply-To: <2B4461BF89BAD511A86100508B66D53802080A35@fmsmsx112.fm.intel.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Cc: 'Antonino Daplas' <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> I agree, I have some API's that I've been using for embedded applications
> and it always seems that if you allow mmap() you must have a sync()
> function. (A flush is nice too but not required)

Hm. There is also the issue of the cache and memory going out of sync. The
question is do we need device specific hooks?


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
