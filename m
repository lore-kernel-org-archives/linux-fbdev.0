From: "Patrick Robin" <circaeng@hotmail.com>
Subject: baiscs of fb driver architecture?
Date: Sat, 27 Mar 2004 18:00:45 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Law10-F1288uxlYjahH00012979@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7I73-0000dL-Ge
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Mar 2004 10:00:53 -0800
Received: from law10-f12.law10.hotmail.com ([64.4.15.12] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7I70-0004QR-FN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Mar 2004 10:00:50 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net



Hello,

I want to write a frame buffer driver for one or our projects running 
uClinux/Nano-X on an embeded platform.

I have read information on the subject from various web sites but I still 
have some basic architecture  questions unanswered.

First here are the specs for the target platform: 32 bit Xilinx Microblaze 
processor core running on a
Xilinx FPGA. This processor runs uClinux, Nano-X and our fltk based 
application. Video output consists of a logic circuit we designed on the 
same FPGA to drive a standard NTSC video monitor in monochrome mode. This 
video logic circuit reads pixel data from a video RAM block shared with the 
Microblaze processor. The video logic circuit is independent of the 
Microblaze processor and generates all timing and data signals to drive the 
NTSC monitor.

Video specs we are using: 256x230 monochrome pixels, standard NTSC fixed 
rates: 60 HZ vertical, 15.7 KHZ horizontal

I have the NTSC driving circuitry workingfine , outputting video data from 
the video RAM to the monitor. The  microblaze processor also has write 
access to this video ram. But I am totally new to writing Linux drivers and 
the concept of linux frame buffer. I have some basic questions:


1) Am I correct in assuming that an application like Nano-X obtains an 
address for video ram from the fb driver and then proceeds to write pixel 
data directly to it as needed by screen updates required by the end user 
application.

2) Is there any synchronization required/expected between the pixel write 
operations to this RAM and the refresh rates of the video circuitry. In othe 
words, doesn the fb driver care when video pixel data is actually transfered 
from video ram to the monitor. If he doesn't, what part of the systems 
syncronizes the application writes VS video data output to avoid flicker?

3) What functionality must the fb driver provide in this context. Does it 
only provide an address for
video pixel ram and all graphic computations are the responsability of the X 
server?

4) Is there docomentation for a beginner writing a fb driver? Like step by 
step for a simple fixed frequency fb driver. I looked at the vfb.c code but 
it is not obvious to me what functionality I need to  provide in there.

5) I assume I also need to become familiar with the basics of writing a 
linux character based driver: structure, compilation, etc . Is there a good 
reference for that?

Thanks in advance for any help


Patrick Robin

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN Premium   
http://join.msn.com/?pgmarket=en-ca&page=byoa/prem&xAPID=1994&DI=1034&SU=http://hotmail.com/enca&HL=Market_MSNIS_Taglines



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
