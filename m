From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK updates] More updates.
Date: 06 Mar 2003 10:11:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046916643.7318.1.camel@localhost.localdomain>
References: <Pine.LNX.4.33.0303051049350.9711-201000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qkpx-0003Y3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 18:10:21 -0800
In-Reply-To: <Pine.LNX.4.33.0303051049350.9711-201000@maxwell.earthlink.net>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 02:13, James Simmons wrote:
> 
> Hi folks. 
> 
>     I just pieced together various patches. I think we need to push this 
> code to linus. It has gotten pretty big.. Can people test  it please 
> before I sen it.
> 
> Diff:  http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

James,

Something's wrong with the patch, it removed fb.h, the Makefiles and
possibly a bunch of other files.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
