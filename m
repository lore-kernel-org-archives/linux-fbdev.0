From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 09:18:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046913407.1227.184.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051858250.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk0E-0007A9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:16:54 -0800
In-Reply-To: <Pine.LNX.4.44.0303051858250.27760-100000@phoenix.infradead.org>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 03:02, James Simmons wrote:
> > Yes, this is a limitation of stty.  It calls con_resize twice (one for
> > row and another for cols, depending on the order of the options) so it
> > will not work if the driver only supports a fixed set of modes.  Another
> > reason to bring back fbset resizing.
> 
> ???? stty rows 128 cols 48 works for me. It should'nt calling con_resize 
> twice. 
> 

It does.  You probably won't notice it if the driver supports flexible
video mode changing.  For drivers that don't it will fail.  For
instance, if a driver supports 800x600 and 1024x768 only, and stty is
used to change the mode from 1024x768 to 800x600, it will be done like
this:

resize to 800x768 <--- because no mode matches this, resizing fails
resize to 800x600

If you don't believe me, do an strace stty cols 80 rows 30.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
