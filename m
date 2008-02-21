From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2/2] xen pvfb: Para-virtual
	framebuffer, keyboard and pointer driver
Date: Fri, 22 Feb 2008 00:37:19 +0800
Message-ID: <45a44e480802210837o6caa9a9k8b26825b31cbf54d@mail.gmail.com>
References: <871w76ejdg.fsf@pike.pond.sub.org>
	<87skzmd4qc.fsf@pike.pond.sub.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSEQH-00038n-Hs for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Feb 2008 08:37:26 -0800
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JSEQE-0000Kn-Qo
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Feb 2008 08:37:25 -0800
Received: by wf-out-1314.google.com with SMTP id 28so50265wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 Feb 2008 08:37:20 -0800 (PST)
In-Reply-To: <87skzmd4qc.fsf@pike.pond.sub.org>
Content-Disposition: inline
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
To: Markus Armbruster <armbru@redhat.com>
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org

On Thu, Feb 21, 2008 at 5:43 PM, Markus Armbruster <armbru@redhat.com> wrote:
>  +config XEN_FBDEV_FRONTEND
>  +       select FB_DEFERRED_IO

Groovy. :-)

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
