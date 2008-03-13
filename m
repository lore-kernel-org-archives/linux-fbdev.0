From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: X patch
Date: Thu, 13 Mar 2008 15:45:06 -0600
Message-ID: <20080313214506.GF6284@cosmic.amd.com>
References: <20080313213125.GE6284@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JZvDT-000649-AO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 14:44:00 -0700
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=outbound2-wa4-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JZvDQ-0003yN-Jx
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 14:43:59 -0700
Received: from outbound2-wa4.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-wa4-R.bigfish.com (Postfix) with ESMTP id 443314725C5
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:43:51 +0000 (UTC)
Received: from mail166-wa4-R.bigfish.com (si1-wa4 [10.8.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound2-wa4.bigfish.com (Postfix) with ESMTP id 42AE3AB0076
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:43:51 +0000 (UTC)
Received: from mail166-wa4 (localhost.localdomain [127.0.0.1])
	by mail166-wa4-R.bigfish.com (Postfix) with ESMTP id 2850E158A0C8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:43:51 +0000 (UTC)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail166-wa4.bigfish.com (Postfix) with ESMTP id 7C1E7151817D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:43:49 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])
	by ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
	m2DLkiip006898 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 16:46:48 -0500
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])
	by ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id
	22ABC194B2D for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 16:43:32 -0500 (CDT)
Received: from cosmic.amd.com (cosmic.amd.com [165.204.144.72])
	by ldcmail.amd.com (Postfix) with ESMTP id 5E02722F4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 15:43:49 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <20080313213125.GE6284@cosmic.amd.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On 13/03/08 15:31 -0600, Jordan Crouse wrote:
> This should do the right thing for the panel - you'll still have a virtual
> desktop if your specified size != the size of the panel, but it won't be
> all funky anymore.

Sorry for that - that was the wrong address on the To line.  Ignore me :)

Jordan
-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
