From: Thomas Jahns <Thomas.Jahns@epost.de>
Subject: Re: Mach64 GX driver problems in post 2.4.22 kernels
Date: Thu, 24 Jun 2004 22:37:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040624203758.GE1965@mercury.jahnsnet.de>
References: <20040605185647.GG5668@mercury.jahnsnet.de> <20040606104530.GA2231@mercury.jahnsnet.de> <20040618094852.GA9466@mercury.jahnsnet.de> <20040621080858.GA11936@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdbLa-0006UL-OD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Jun 2004 14:01:26 -0700
Received: from mail.epost.de ([193.28.100.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdbLa-0003Vt-3R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Jun 2004 14:01:26 -0700
Content-Disposition: inline
In-Reply-To: <20040621080858.GA11936@havoc.gtf.org> (from eger@havoc.gtf.org on Mon, Jun 21, 2004 at 10:08:58 +0200)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: David Eger <eger@havoc.gtf.org>
Cc: Thomas Jahns <Thomas.Jahns@epost.de>, linux-fbdev-devel@lists.sourceforge.net


--FL5UXtIhxfXey3p5
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 06/21/04 10:08:58, David Eger wrote:
> 
> Could you send your .config?  (This could only help with the most
> trivial of problems, but worth a shot.)

Okay, I'll bzip the .configs and also include a diff I created from  
both files with the following sequence of commands (tungsten is the  
hostname of the Pmac in question):

 > grep -v '^#' ../boot/config-2.4.22-tungsten >config-2.4.22-tungsten. 
cleanup
 > grep -v '^#' ../boot/config-2.4.25-tungsten >config-2.4.25-tungsten. 
cleanup
 > diff -u config-2.4.2*cleanup >dot.config.diff-u

see below for the diff. PREEMPT is no longer selected because this diff  
is already for a kernel configuration that I did not patch as much as  
the working 2.4.22 kernel to limit the potential error sources.

> You're posting to the right list; you're probably not getting
> responses because none of the active framebuffer developers have a  
> setup similar enough to yours :-/

That's unfortunate, I think quite a number of Macs in the 9500 and 9600  
lines came preinstalled with such cards and ATI cards were also a  
popular upgrade for Mac graphics at that time.

> At least, that's why I'd not responded... still trying to debug  
> radeon and cirrus...

I'm also a user of the radeon driver so keep up the good work.

Ciao, Thomas

--- config-2.4.22-tungsten.cleanup	2004-06-24 22:30:01.000000000  
+0200
+++ config-2.4.25-tungsten.cleanup	2004-06-24 22:30:07.000000000  
+0200
@@ -11,9 +11,12 @@
 CONFIG_6xx=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_ALL_PPC=y
-CONFIG_PREEMPT=y
 CONFIG_PPC_ISATIMER=y

+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
 CONFIG_PCI=y
 CONFIG_NET=y
 CONFIG_SYSCTL=y
@@ -93,6 +96,10 @@
 CONFIG_IP_NF_TARGET_LOG=m
 CONFIG_IP_NF_TARGET_ULOG=m
 CONFIG_IP_NF_TARGET_TCPMSS=m
+
+
+CONFIG_IPV6_SCTP__=y
+
 CONFIG_ATALK=m


@@ -100,6 +107,7 @@


 CONFIG_SCSI=y
+
 CONFIG_BLK_DEV_SD=y
 CONFIG_SD_EXTRA_DEVS=40
 CONFIG_CHR_DEV_ST=y
@@ -107,6 +115,7 @@
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_SR_EXTRA_DEVS=2
 CONFIG_CHR_DEV_SG=m
+
 CONFIG_SCSI_CONSTANTS=y

 CONFIG_SCSI_AIC7XXX_OLD=y
@@ -178,9 +187,12 @@



+
 CONFIG_NVRAM=y

+
 CONFIG_DRM=y
+
 CONFIG_DRM_NEW=y
 CONFIG_DRM_R128=m

@@ -218,11 +230,9 @@

 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
-CONFIG_NFS_ACL=y
 CONFIG_NFS_DIRECTIO=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
-CONFIG_NFSD_ACL=y
 CONFIG_NFSD_TCP=y
 CONFIG_SUNRPC=m
 CONFIG_LOCKD=m
@@ -251,6 +261,9 @@
 CONFIG_SOUND=y
 CONFIG_DMASOUND_PMAC=m
 CONFIG_DMASOUND=m
+CONFIG_I2C=m
+CONFIG_I2C_KEYWEST=m
+



@@ -273,6 +286,6 @@
 CONFIG_CRC32=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
-CONFIG_QSORT=y

 CONFIG_BOOTX_TEXT=y
+CONFIG_LOG_BUF_SHIFT=0


--FL5UXtIhxfXey3p5
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="config-2.4.22-tungsten.bz2"
Content-Transfer-Encoding: base64

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
s/oz3gERFZrpOnJd3uVjM7v/F3JFOFCQHyGAhQ==

--FL5UXtIhxfXey3p5
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="config-2.4.25-tungsten.bz2"
Content-Transfer-Encoding: base64

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

--FL5UXtIhxfXey3p5--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
