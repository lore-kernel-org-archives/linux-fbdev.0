From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: A strange question for LCD
Date: Mon, 4 Oct 2004 21:39:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041004193911.GC16840@uvt316-2.ruk.cuni.cz>
References: <BAY17-F22jQHtMFauky00016eb2@hotmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEYiv-000225-WF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 12:42:18 -0700
Received: from dec59.ruk.cuni.cz ([195.113.2.17])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CEYiu-0007qX-RI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 12:42:17 -0700
Content-Disposition: inline
In-Reply-To: <BAY17-F22jQHtMFauky00016eb2@hotmail.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

On Mon, Oct 04, 2004 at 03:15:40PM +0000, z g wrote:
> I have a LCD(LQ035q7db02). It supports 240X320(H X W). I have a frame 
> buffer driver for it and it works well. But I have to change the display 
> mode in 320X240 (H X W) . I don't know whether I can change the frame 
> buffer driver to implement it. If can, how to change the driver. If anyone 
> can help me? Thanks!
Perhaps you want fbset?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
