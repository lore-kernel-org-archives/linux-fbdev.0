From: Nishant Kamat <nishantkamat@gmail.com>
Subject: Rotation in 2.4 kernel
Date: Fri, 21 Jan 2005 12:58:12 -0600
Message-ID: <ba2a6a4405012110581bcebd3b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs3zF-0004wp-T5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 10:58:25 -0800
Received: from wproxy.gmail.com ([64.233.184.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cs3zD-00066p-I4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 10:58:25 -0800
Received: by wproxy.gmail.com with SMTP id 71so135768wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Jan 2005 10:58:12 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

In 2.4, is there a standard way (API) for drivers to support rotation?
In 2.6, I think applications use the var info structure to set the
rotate field. How do applications tell 2.4 framebuffer drivers to
cause rotation on the fly?  Would be great if someone can shed some
light.

Thanks,
Nishant


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
