From: selvaganesan <selvaganesan@gmail.com>
Subject: Mirroring the display
Date: Thu, 16 Aug 2007 12:41:36 +0530
Message-ID: <ce8e877b0708160011p83b8648j96749433b3857d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643625212=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILZW5-0002Oq-Ly for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 00:11:38 -0700
Received: from rv-out-0910.google.com ([209.85.198.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILZW5-0008MR-Ao
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 00:11:37 -0700
Received: by rv-out-0910.google.com with SMTP id g11so333570rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Aug 2007 00:11:37 -0700 (PDT)
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

--===============1643625212==
Content-Type: multipart/alternative; 
	boundary="----=_Part_32227_30718745.1187248296890"

------=_Part_32227_30718745.1187248296890
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

I would like to capture the primary display and send it over the
network. All the primary display will be mirroring in the network pcs.

Functionality is exactly as same as VNC.
Remote pc should have control and events of
primary display as like as VNC.

I have a few ideas but not sure about it.

i) Accessing the framebuffer and sending it across the network.

    Doubts in this approach:

       1. Will it be a generic solution as hardware independent?
       2. Will it be fast?
       3. Will i be able to control and events from the remote pc as like as
VNC?
       4. Do i need to change any configurations? any configuration
dependent?

       5.Is  it feasible?



ii) Accesing the X Window, hooking it and sending it across the network as
VNC does.

       1.Will it be fast?

       2.Is it feasible?


Can anybody suggest me the best way to do this?

Where can i start now?

Thanks in advance,

selva

------=_Part_32227_30718745.1187248296890
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Dear all, </div>
<div>&nbsp;</div>
<div>I&nbsp;would like to capture the primary display and send it over the<br>network. All the primary display will be mirroring in the network pcs.
<p>Functionality is exactly as same as VNC. <br>Remote pc should have control and events of<br>primary display as like as VNC.</p>
<p>I have a few ideas but not sure about it. </p>
<p>i) Accessing the framebuffer and sending it across the network.<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; Doubts in this approach:</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. Will it be a generic solution as hardware independent?<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. Will it be fast?<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. Will i be able to control and events from the remote pc as like as VNC?<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. Do i need to change any configurations? any configuration dependent?&nbsp;
</p>
<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 5.Is&nbsp; it feasible?<br>&nbsp;&nbsp;&nbsp; </p>
<p><br>ii) Accesing the X Window, hooking it and sending it across the network as VNC does. </p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.Will it be fast? </p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.Is it feasible?</p>
<p><br>Can anybody suggest me the best way to do this?</p>
<p>Where can i start now?</p>
<p>Thanks in advance,</p>
<p>selva</p>
<p>&nbsp;</p></div>

------=_Part_32227_30718745.1187248296890--


--===============1643625212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1643625212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1643625212==--
