From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Openzaurus-devel] Re: Linux 2.6 fbcon	rotation
 - in software
Date: Thu, 27 Oct 2005 08:09:13 +0800
Message-ID: <43601AA9.3040103@gmail.com>
References: <1130301527.27554.246030407@webmail.messagingengine.com>	 <435F6C77.7010603@gmail.com> <1130366966.8322.57.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUvKp-0003dR-QG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 17:09:35 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EUvKp-0001uv-8S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 17:09:35 -0700
Received: by zproxy.gmail.com with SMTP id 14so205958nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Oct 2005 17:09:34 -0700 (PDT)
In-Reply-To: <1130366966.8322.57.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, openzaurus-devel@lists.sourceforge.net, hasjim.williams@futaris.org

Richard Purdie wrote:
> On Wed, 2005-10-26 at 19:45 +0800, Antonino A. Daplas wrote:
>> Hasjim Williams wrote:
>>> Hi all,
>>>
>>> I am looking to rotate the framebuffer console on an embedded ARM
>>> device.  I know that both OPIE and GPE (X Windows) support screen
>>> rotation in software.  I think they use a shadow framebuffer...  Has
>>> anyone on either of the lists started implementing this in 2.6.x ???  I
>>> know the Zaurus CL-3xxx series use the pxafb driver and fbcon is rotated
>>> on these devices.  My platform uses the amba_clcd driver and fbcon is
>>> also rotated on this device.
>>>
>>> See http://sourceforge.net/mailarchive/message.php?msg_id=12904686 for
>>> the Zaurus info.
>>>
>>> Is there some easy / good way to add rotated console support to the
>>> kernel?  Or do we have to use a shadow framebuffer?
>> I had a patch that does software rotation for the framebuffer console. But
>> this was during 2.5. The patch does this by having different putcs, putc,
>> bmove, fill, and cursor methods depending on the orientation.
>>
>> If this is really desired, I may try to revive that patch...
> 
> I was asked about this offlist and sent Hasjim a copy of the 2.5 patch. 
> 
> Console rotation would be extremely useful for several of the Zaurus
> devices (Collie, Spitz, Akita and Borzoi). These use pxafb or sa1100fb
> which don't support rotation in hardware. (The other Zaurus models use
> w100fb which does support hardware rotation).
> 

Ok, I have some spare time this weekend to update the patch.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
