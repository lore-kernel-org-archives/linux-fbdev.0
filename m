From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
Subject: RE: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sat, 11 Nov 2006 11:17:03 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE6B5437@labex2.corp.trema.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754363AbWKKK0d@vger.kernel.org>
content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl, Hoffmann@albercik.sisk.pl


>There are many possible reasons for that. The most likely is that the
>BIOS isn't bringing the chip back on resume, causing radeonfb to
>crash when trying to access it.

>Ben.
Is there any possible workaround for this, or some tracing possible so
we can prove the hypothesis?

Chris



Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.
