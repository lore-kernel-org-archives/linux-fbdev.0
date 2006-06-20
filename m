From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc6-mm2] fbdev: tag
 by	scantype in sysfs
Date: Tue, 20 Jun 2006 18:29:56 +0800
Message-ID: <4497CE24.7050908@gmail.com>
References: <4497AA7A.5050507@st.com> <4497B4FA.2080602@pol.net>
	<4497C289.5060007@st.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsdUm-0004F1-WC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 03:30:09 -0700
Received: from nz-out-0102.google.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsdUl-0004Kc-MF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 03:30:08 -0700
Received: by nz-out-0102.google.com with SMTP id 13so1251104nzp
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 03:30:07 -0700 (PDT)
In-Reply-To: <4497C289.5060007@st.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@pol.net>

Daniel THOMPSON wrote:
> Antonino A. Daplas wrote:
>> Daniel THOMPSON wrote:
>>> There has been no further comment since this was posted in early May.
>>> This either means is uncontentious or useless ... I hope the former.
>>>
>> I thought you were still in 'discussion' mode with Geert :-)
> 
> I was, but there was no further discussion so I brought it back to you.
> 
>> Anyway, this should be fine, I'm just a bit worried that it might
>> break existing user apps that might be used to having modes without
>> the scan type specified.
> 
> I shared this worry which is why my original patch only tagged the,
> comparatively rare, interlaced modes. However the current approach (no
> optional fields) is slightly cleaner and I took the view that since
> no-one on fbdev-devel seems to object ...
> 

Okay.  But if we are going to break this, let's break it with finality.
Does anyone believe that the above format is final? How about including
sync signals too?  

#define FB_SYNC_HOR_HIGH_ACT	1	/* horizontal sync high active	*/
#define FB_SYNC_VERT_HIGH_ACT	2	/* vertical sync high active	*/
#define FB_SYNC_EXT		4	/* external sync		*/
#define FB_SYNC_COMP_HIGH_ACT	8	/* composite sync high active   */
#define FB_SYNC_BROADCAST	16	/* broadcast video timings      */

Secondly, that attribute 'modes' violate the 'one file, one value' rule of
sysfs (and that includes 'virtual_size', and 'pan').  We need to clean
these up.  How about something like this?

/sys/class/graphics---fb0
                    :
                    --fb1
                    :
                    --fbn
                    :
                    --mode0---640x480@60
                    :       :
                    :       --1024x768@60
                    :  
                    --mode1

where mode[n] represents the currently attached display to fb[n]

Tony
