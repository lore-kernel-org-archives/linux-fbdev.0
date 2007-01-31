From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] matroxfb: another attempt to
 rectify jitter (G450/G550)
Date: Wed, 31 Jan 2007 15:58:11 -0600
Message-ID: <45C110F3.10202@us.ibm.com>
References: <45B55422.4070401@us.ibm.com> <45BC58E9.9020306@vandrovec.name>
	<45BFA90D.5050207@us.ibm.com> <20070131115430.GB5039@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCNTx-000478-FP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 13:59:10 -0800
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCNTu-0006h8-VU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 13:59:09 -0800
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l0VLwCfG022003
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Jan 2007 16:58:12 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0VLwCFl527950 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Jan 2007 14:58:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0VLwCwo028749 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Jan 2007 14:58:12 -0700
In-Reply-To: <20070131115430.GB5039@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, Petr Vandrovec <petr@vandrovec.name>

Ville Syrj=E4l=E4 wrote:
> On Tue, Jan 30, 2007 at 02:22:37PM -0600, Paul A. Clarke wrote:
> snip...
>> +				/* DVI PLL preferred for frequencies up to panellink max, standard =
PLL
>> otherwise */
>> +				if (fout >=3D MINFO->max_pixel_clock_panellink) tmp =3D 0;
>> +				else tmp =3D
>> +					M1064_XDVICLKCTRL_DVIDATAPATHSEL |
>> +					M1064_XDVICLKCTRL_C1DVICLKSEL |
>> +					M1064_XDVICLKCTRL_C1DVICLKEN |
> =

> Shouldn't this check which CRTC is driving the DVI?

If I read the code correctly, I don't see any way this code gets invoked fo=
r CRTC2.  __g450_setclk() is only called by =

matroxfb_g450_setclk(), which is in turn called in 8 places:
- 2 with pll =3D=3D M_VIDEO_PLL (a different case in the enclosing switch)
- 1 with pll =3D=3D M_SYSTEM_PLL (a different case in the enclosing switch)
- 3 which if (m->crtc !=3D MATROXFB_SRC_CRTC1) then pll =3D=3D M_VIDEO_PLL
- 2 with M_PIXEL_PLL_A and M_PIXEL_PLL_B (once each) at init time to set le=
gacy VGA clocks with both CRTCs disabled

>> +					M1064_XDVICLKCTRL_DVILOOPCTL |
>> +					M1064_XDVICLKCTRL_P1LOOPBWDTCTL;
>> +				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL,tmp);
>>    				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl);
>>
>>    				matroxfb_DAC_unlock_irqrestore(flags);

I'll also admit that my level of expertise here is not what I'd prefer, but=
 my (perhaps suboptimal) testing showed good results.
-- =

Regards,
Paul Clarke

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
