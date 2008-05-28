From: Denis Oliver Kropp <dok-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
Subject: DirectFB without FBDev
Date: Wed, 28 May 2008 16:59:16 +0200
Message-ID: <483D7344.6030503@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.directfb.org/pipermail/directfb-users>
List-Post: <mailto:directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users>,
	<mailto:directfb-users-request-iGvX3keArt1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Sender: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Errors-To: directfb-users-bounces-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
To: directfb-dev-iGvX3keArt1g9hUCZPvPmw@public.gmane.org, directfb-users-iGvX3keArt1g9hUCZPvPmw@public.gmane.org
Cc: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Hi,

after getting too depressed by the current state of the FBDev backend with the new
surface core I decided to drop FBDev support as it no longer fits into the architecture.

If you feel you like to fix the frame buffer device system module or better the frame
buffer device itself, you're welcome to help the FBDev backend to creep over the 1.2 hurdle...

One major bug at the moment is mode switching and pitch values being wrong. It's dumb to
return the pitch of the variable mode settings in the fixed settings structure anyhow, but
if you like to start with the above mentioned mission, that's where it could begin.

And while you're at it, please also add an ioctl to just simply set the display offset without
a virtual resolution and x/y offset values within the whole frame buffer...

I have no idea why the FBDev backend uses the wrong pitch (4096) after switching to RGB16 which
should have a pitch of 2048. One out of ten tries did work though. I remember it has been
working once I added several workarounds and hacks to keep the FBDev backend alive, but somehow
the code or core have changed, I don't know and I'm not in the mood of spending time on cruft
like VTs, FBDev etc...

Volunteers are welcome, urgently, I'm going to make a first release candidate of 1.2 tomorrow,
most likely after removing the fbdev system module.

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
