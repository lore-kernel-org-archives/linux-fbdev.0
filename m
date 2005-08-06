From: Dave Airlie <airlied@linux.ie>
Subject: Re: CRTC scanout buffer types
Date: Sun, 7 Aug 2005 00:45:16 +0100 (IST)
Message-ID: <Pine.LNX.4.58.0508070043520.30320@skynet>
References: <9e47339105080513195dee0804@mail.gmail.com>
 <200508061924.03205.pmcfarland@downeast.net>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508061924.03205.pmcfarland@downeast.net>
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> > Note, the r200 supports a lot more buffer formats, but these are the
> > only ones valid for scanout.
>
> What does scanout mean?

the sending of a graphics buffer from VRAM to monitor via a CRTC... CRTCs
only support certain formats...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
