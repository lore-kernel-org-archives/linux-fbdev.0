From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 23:21:17 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E66785D.1070202@winischhofer.net>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qhFT-0001Eh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 14:20:27 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
> I disagree that fbset is the solution to all things. The problem is 
> fbcon_resize is severally broken. The reality is that there are fixed mode 
> resolutions (i.e. LCD displays). So fbcon has to adpat to this. What we 
> shoudl do is set the console mode fit slightly smaller than that the 
> actually resolution. The reason being is partially drawn fonts at the 
> bottom of the screen would look bad. So clearing the margins also has to 
> be fixed. This way we clean up the screen for situtations where the 
> console screen size doesn't quite fit the resolution. This is what shoudl 
> be done. 

Excuse me that I dare to comment on this as a total fbdev-rookie:

Please think about usability, too. Forcing people to fiddle with rows 
and cols, requiring knowledge about font sizes and stuff is at least 
inappropriate. Folks are used to think in resolutions, that's what they 
understand, and that's what is most obvious. I can't imagine anyone 
caring about the amount of rows or columns on a text screen.

BTW: What happens currently if I instruct console to replace the current 
font with a bigger one (if that's possible at run-time at all) ?

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
